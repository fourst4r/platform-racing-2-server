package main

import (
	"context"
	"crypto/sha256"
	"crypto/tls"
	"encoding/base64"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"log"
	"net"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"sync"
	"time"
)

const (
	searchBodyLimit = 8 * 1024
	defaultTTL      = 2 * time.Minute
)

var (
	levelRoutePattern = regexp.MustCompile(`^/levels/([1-9][0-9]*)\.txt$`)
	versionPattern    = regexp.MustCompile(`^[0-9]*$`)
)

type routeKind string

const (
	routeKindLists     routeKind = "lists"
	routeKindSearch    routeKind = "search"
	routeKindLevels    routeKind = "levels"
	routeKindLevelData routeKind = "level_data"
)

type cacheEntry struct {
	StatusCode  int       `json:"status_code"`
	ContentType string    `json:"content_type"`
	BodyBase64  string    `json:"body_base64"`
	FetchedAt   time.Time `json:"fetched_at"`
	ExpiresAt   time.Time `json:"expires_at"`
}

func (e *cacheEntry) Body() ([]byte, error) {
	return base64.StdEncoding.DecodeString(e.BodyBase64)
}

func (e *cacheEntry) IsFresh(now time.Time) bool {
	return now.Before(e.ExpiresAt)
}

type cacheStore struct {
	baseDir string
}

func newCacheStore(baseDir string) *cacheStore {
	return &cacheStore{baseDir: baseDir}
}

func (s *cacheStore) Get(kind routeKind, key string) (*cacheEntry, bool, error) {
	path := s.pathFor(kind, key)
	data, err := os.ReadFile(path)
	if err != nil {
		if errors.Is(err, os.ErrNotExist) {
			return nil, false, nil
		}
		return nil, false, err
	}

	var entry cacheEntry
	if err := json.Unmarshal(data, &entry); err != nil {
		_ = os.Remove(path)
		return nil, false, nil
	}

	if _, err := entry.Body(); err != nil {
		_ = os.Remove(path)
		return nil, false, nil
	}

	return &entry, true, nil
}

func (s *cacheStore) Save(kind routeKind, key string, entry *cacheEntry) error {
	path := s.pathFor(kind, key)
	dir := filepath.Dir(path)
	if err := os.MkdirAll(dir, 0o755); err != nil {
		return err
	}

	data, err := json.Marshal(entry)
	if err != nil {
		return err
	}

	tmpPath := path + ".tmp"
	if err := os.WriteFile(tmpPath, data, 0o644); err != nil {
		return err
	}
	return os.Rename(tmpPath, path)
}

func (s *cacheStore) Delete(kind routeKind, key string) error {
	path := s.pathFor(kind, key)
	err := os.Remove(path)
	if errors.Is(err, os.ErrNotExist) {
		return nil
	}
	return err
}

func (s *cacheStore) DeleteExpiredLevelEntries(now time.Time) error {
	dir := filepath.Join(s.baseDir, string(routeKindLevels))
	entries, err := os.ReadDir(dir)
	if err != nil {
		if errors.Is(err, os.ErrNotExist) {
			return nil
		}
		return err
	}

	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}

		path := filepath.Join(dir, entry.Name())
		data, readErr := os.ReadFile(path)
		if readErr != nil {
			continue
		}

		var cached cacheEntry
		if err := json.Unmarshal(data, &cached); err != nil {
			_ = os.Remove(path)
			continue
		}

		if !cached.ExpiresAt.IsZero() && !now.Before(cached.ExpiresAt) {
			_ = os.Remove(path)
		}
	}

	return nil
}

func (s *cacheStore) pathFor(kind routeKind, key string) string {
	sum := sha256.Sum256([]byte(key))
	filename := hex.EncodeToString(sum[:]) + ".json"
	return filepath.Join(s.baseDir, string(kind), filename)
}

type config struct {
	ListenAddr         string
	CacheDir           string
	UpstreamBase       string
	UserAgent          string
	Timeout            time.Duration
	InsecureSkipVerify bool
	ListTTLs           map[string]time.Duration
	SearchTTL          time.Duration
	LevelTTL           time.Duration
	LevelDataTTL       time.Duration
}

func loadConfig() config {
	return config{
		ListenAddr:         envOr("PROXY_LISTEN_ADDR", ":8080"),
		CacheDir:           envOr("PROXY_CACHE_DIR", "/cache"),
		UpstreamBase:       strings.TrimRight(envOr("PROXY_UPSTREAM_BASE", "https://pr2hub.com"), "/"),
		UserAgent:          envOr("PROXY_USER_AGENT", "trapwork-pr2hub-proxy/1.0"),
		Timeout:            durationEnvOr("PROXY_TIMEOUT", 10*time.Second),
		InsecureSkipVerify: boolEnvOr("PROXY_INSECURE_SKIP_VERIFY", false),
		ListTTLs: map[string]time.Duration{
			"campaign":  durationEnvOr("PROXY_CAMPAIGN_TTL", 30*time.Minute),
			"best":      durationEnvOr("PROXY_BEST_TTL", 15*time.Minute),
			"best_week": durationEnvOr("PROXY_BEST_WEEK_TTL", 3*time.Minute),
			"newest":    durationEnvOr("PROXY_NEWEST_TTL", 45*time.Second),
		},
		SearchTTL:    durationEnvOr("PROXY_SEARCH_TTL", 90*time.Second),
		LevelTTL:     durationEnvOr("PROXY_LEVEL_TTL", 24*time.Hour),
		LevelDataTTL: durationEnvOr("PROXY_LEVEL_DATA_TTL", 2*time.Minute),
	}
}

func envOr(key, fallback string) string {
	if value := strings.TrimSpace(os.Getenv(key)); value != "" {
		return value
	}
	return fallback
}

func durationEnvOr(key string, fallback time.Duration) time.Duration {
	value := strings.TrimSpace(os.Getenv(key))
	if value == "" {
		return fallback
	}
	dur, err := time.ParseDuration(value)
	if err != nil {
		return fallback
	}
	return dur
}

func boolEnvOr(key string, fallback bool) bool {
	value := strings.TrimSpace(strings.ToLower(os.Getenv(key)))
	if value == "" {
		return fallback
	}
	return value == "1" || value == "true" || value == "yes" || value == "on"
}

type proxyRoute struct {
	Kind          routeKind
	Method        string
	CacheKey      string
	CacheTTL      time.Duration
	AllowStale    bool
	UpstreamURL   string
	UpstreamBody  []byte
	ContentType   string
	RouteLabel    string
	NormalizedKey string
}

func buildRoute(r *http.Request, cfg config) (*proxyRoute, error) {
	switch {
	case r.Method == http.MethodGet && r.URL.Path == "/healthz":
		return &proxyRoute{RouteLabel: "healthz"}, nil
	case strings.HasPrefix(r.URL.Path, "/files/lists/"):
		return buildListRoute(r, cfg)
	case r.URL.Path == "/search_levels.php":
		return buildSearchRoute(r, cfg)
	case strings.HasPrefix(r.URL.Path, "/levels/"):
		return buildLevelRoute(r, cfg)
	case r.URL.Path == "/level_data.php":
		return buildLevelDataRoute(r, cfg)
	default:
		return nil, newHTTPError(http.StatusNotFound, "unknown proxy route")
	}
}

func buildListRoute(r *http.Request, cfg config) (*proxyRoute, error) {
	if r.Method != http.MethodGet {
		return nil, newHTTPError(http.StatusMethodNotAllowed, "method not allowed")
	}

	trimmed := strings.Trim(strings.TrimPrefix(r.URL.Path, "/"), "/")
	parts := strings.Split(trimmed, "/")
	if len(parts) != 4 || parts[0] != "files" || parts[1] != "lists" {
		return nil, newHTTPError(http.StatusNotFound, "unknown list route")
	}

	mode := parts[2]
	page := parts[3]
	ttl, ok := cfg.ListTTLs[mode]
	if !ok {
		return nil, newHTTPError(http.StatusBadRequest, "invalid list mode")
	}

	if _, err := parsePositiveInt(page); err != nil {
		return nil, newHTTPError(http.StatusBadRequest, "invalid list page")
	}

	if err := validateOptionalTokenAndRandQuery(r.URL.Query()); err != nil {
		return nil, err
	}

	return &proxyRoute{
		Kind:          routeKindLists,
		Method:        http.MethodGet,
		CacheKey:      fmt.Sprintf("lists:%s:%s", mode, page),
		CacheTTL:      ttl,
		AllowStale:    true,
		UpstreamURL:   fmt.Sprintf("%s/files/lists/%s/%s", cfg.UpstreamBase, mode, page),
		RouteLabel:    "files/lists",
		NormalizedKey: fmt.Sprintf("%s/%s", mode, page),
	}, nil
}

func buildSearchRoute(r *http.Request, cfg config) (*proxyRoute, error) {
	if r.Method != http.MethodPost {
		return nil, newHTTPError(http.StatusMethodNotAllowed, "method not allowed")
	}

	if rawQuery := r.URL.RawQuery; rawQuery != "" {
		return nil, newHTTPError(http.StatusBadRequest, "unexpected query parameters")
	}

	body, err := readLimitedBody(r.Body, searchBodyLimit)
	if err != nil {
		return nil, err
	}

	values, err := url.ParseQuery(string(body))
	if err != nil {
		return nil, newHTTPError(http.StatusBadRequest, "invalid form body")
	}

	const (
		modeKey      = "mode"
		searchStrKey = "search_str"
		orderKey     = "order"
		dirKey       = "dir"
		pageKey      = "page"
		tokenKey     = "token"
		randKey      = "rand"
	)

	allowed := map[string]bool{
		modeKey:      true,
		searchStrKey: true,
		orderKey:     true,
		dirKey:       true,
		pageKey:      true,
		tokenKey:     true,
		randKey:      true,
	}

	normalized := url.Values{}
	for key, vals := range values {
		if !allowed[key] {
			return nil, newHTTPError(http.StatusBadRequest, "unexpected form field")
		}
		if len(vals) != 1 {
			return nil, newHTTPError(http.StatusBadRequest, "duplicate form field")
		}
		if key == tokenKey || key == randKey {
			continue
		}
		normalized.Set(key, vals[0])
	}

	if pageValue := normalized.Get(pageKey); pageValue != "" {
		if _, err := parsePositiveInt(pageValue); err != nil {
			return nil, newHTTPError(http.StatusBadRequest, "invalid search page")
		}
	}

	encoded := normalized.Encode()
	if encoded == "" {
		encoded = string(body)
	}

	return &proxyRoute{
		Kind:          routeKindSearch,
		Method:        http.MethodPost,
		CacheKey:      "search:" + encoded,
		CacheTTL:      cfg.SearchTTL,
		AllowStale:    true,
		UpstreamURL:   cfg.UpstreamBase + "/search_levels.php",
		UpstreamBody:  []byte(encoded),
		ContentType:   "application/x-www-form-urlencoded",
		RouteLabel:    "search_levels.php",
		NormalizedKey: encoded,
	}, nil
}

func buildLevelRoute(r *http.Request, cfg config) (*proxyRoute, error) {
	if r.Method != http.MethodGet {
		return nil, newHTTPError(http.StatusMethodNotAllowed, "method not allowed")
	}

	match := levelRoutePattern.FindStringSubmatch(r.URL.Path)
	if match == nil {
		return nil, newHTTPError(http.StatusNotFound, "unknown level route")
	}

	levelID := match[1]
	version := r.URL.Query().Get("version")
	if !versionPattern.MatchString(version) {
		return nil, newHTTPError(http.StatusBadRequest, "invalid level version")
	}
	if len(r.URL.Query()) > 1 || (len(r.URL.Query()) == 1 && r.URL.Query().Get("version") == "" && r.URL.RawQuery != "" && !strings.HasPrefix(r.URL.RawQuery, "version=")) {
		return nil, newHTTPError(http.StatusBadRequest, "unexpected query parameters")
	}

	upstreamURL := fmt.Sprintf("%s/levels/%s.txt", cfg.UpstreamBase, levelID)
	if version != "" {
		query := url.Values{}
		query.Set("version", version)
		upstreamURL += "?" + query.Encode()
	}

	return &proxyRoute{
		Kind:          routeKindLevels,
		Method:        http.MethodGet,
		CacheKey:      fmt.Sprintf("levels:%s:%s", levelID, version),
		CacheTTL:      cfg.LevelTTL,
		AllowStale:    false,
		UpstreamURL:   upstreamURL,
		RouteLabel:    "levels",
		NormalizedKey: fmt.Sprintf("%s@%s", levelID, version),
	}, nil
}

func buildLevelDataRoute(r *http.Request, cfg config) (*proxyRoute, error) {
	if r.Method != http.MethodGet {
		return nil, newHTTPError(http.StatusMethodNotAllowed, "method not allowed")
	}

	query := r.URL.Query()
	if err := validateOptionalTokenAndRandQuery(query); err != nil {
		return nil, err
	}

	levelID := query.Get("level_id")
	if _, err := parsePositiveInt(levelID); err != nil {
		return nil, newHTTPError(http.StatusBadRequest, "invalid level_id")
	}

	upstreamQuery := url.Values{}
	upstreamQuery.Set("level_id", levelID)

	return &proxyRoute{
		Kind:          routeKindLevelData,
		Method:        http.MethodGet,
		CacheKey:      "level_data:" + levelID,
		CacheTTL:      cfg.LevelDataTTL,
		AllowStale:    true,
		UpstreamURL:   cfg.UpstreamBase + "/level_data.php?" + upstreamQuery.Encode(),
		RouteLabel:    "level_data.php",
		NormalizedKey: levelID,
	}, nil
}

func parsePositiveInt(value string) (int, error) {
	if value == "" {
		return 0, errors.New("empty")
	}
	num, err := strconv.Atoi(value)
	if err != nil || num <= 0 {
		return 0, errors.New("invalid")
	}
	return num, nil
}

func validateOptionalTokenAndRandQuery(values url.Values) error {
	if len(values) == 0 {
		return nil
	}

	allowed := map[string]bool{
		"token":    true,
		"rand":     true,
		"level_id": true,
		"version":  true,
	}

	for key, vals := range values {
		if !allowed[key] {
			return newHTTPError(http.StatusBadRequest, "unexpected query parameters")
		}
		if len(vals) != 1 {
			return newHTTPError(http.StatusBadRequest, "duplicate query parameter")
		}
	}

	return nil
}

func readLimitedBody(body io.ReadCloser, limit int64) ([]byte, error) {
	defer body.Close()
	data, err := io.ReadAll(io.LimitReader(body, limit+1))
	if err != nil {
		return nil, newHTTPError(http.StatusBadRequest, "could not read request body")
	}
	if int64(len(data)) > limit {
		return nil, newHTTPError(http.StatusRequestEntityTooLarge, "request body too large")
	}
	return data, nil
}

type httpError struct {
	Status  int
	Message string
}

func newHTTPError(status int, message string) *httpError {
	return &httpError{Status: status, Message: message}
}

func (e *httpError) Error() string {
	return e.Message
}

type upstreamError struct {
	StatusCode  int
	ContentType string
	Body        []byte
	Err         error
}

func (e *upstreamError) Error() string {
	if e.Err != nil {
		return e.Err.Error()
	}
	if e.StatusCode > 0 {
		return fmt.Sprintf("upstream returned status %d", e.StatusCode)
	}
	return "upstream request failed"
}

func (e *upstreamError) Unwrap() error {
	return e.Err
}

func allowsStaleFallback(err error) bool {
	var upErr *upstreamError
	if errors.As(err, &upErr) {
		if upErr.StatusCode == http.StatusTooManyRequests || upErr.StatusCode >= 500 {
			return true
		}
		return upErr.StatusCode == 0 && upErr.Err != nil
	}
	return err != nil
}

type fetchResult struct {
	Entry          *cacheEntry
	UpstreamStatus int
}

type fetchGroup struct {
	mu    sync.Mutex
	calls map[string]*fetchCall
}

type fetchCall struct {
	wg     sync.WaitGroup
	result *fetchResult
	err    error
}

func newFetchGroup() *fetchGroup {
	return &fetchGroup{calls: make(map[string]*fetchCall)}
}

func (g *fetchGroup) Do(key string, fn func() (*fetchResult, error)) (*fetchResult, error) {
	g.mu.Lock()
	if call, ok := g.calls[key]; ok {
		g.mu.Unlock()
		call.wg.Wait()
		return call.result, call.err
	}

	call := &fetchCall{}
	call.wg.Add(1)
	g.calls[key] = call
	g.mu.Unlock()

	call.result, call.err = fn()
	call.wg.Done()

	g.mu.Lock()
	delete(g.calls, key)
	g.mu.Unlock()

	return call.result, call.err
}

type rateLimiter struct {
	mu      sync.Mutex
	windows map[string]*rateWindow
}

type rateWindow struct {
	start time.Time
	count int
}

type rateLimit struct {
	Window time.Duration
	Limit  int
}

func newRateLimiter() *rateLimiter {
	return &rateLimiter{windows: make(map[string]*rateWindow)}
}

func (l *rateLimiter) Allow(key string, cfg rateLimit, now time.Time) bool {
	l.mu.Lock()
	defer l.mu.Unlock()

	window, ok := l.windows[key]
	if !ok || now.Sub(window.start) >= cfg.Window {
		l.windows[key] = &rateWindow{start: now, count: 1}
		return true
	}

	if window.count >= cfg.Limit {
		return false
	}

	window.count++
	return true
}

type server struct {
	cfg         config
	cache       *cacheStore
	httpClient  *http.Client
	fetches     *fetchGroup
	rateLimiter *rateLimiter
}

func newServer(cfg config) *server {
	transport := &http.Transport{
		Proxy: http.ProxyFromEnvironment,
		TLSClientConfig: &tls.Config{
			InsecureSkipVerify: cfg.InsecureSkipVerify,
		},
	}

	return &server{
		cfg:   cfg,
		cache: newCacheStore(cfg.CacheDir),
		httpClient: &http.Client{
			Timeout:   cfg.Timeout,
			Transport: transport,
		},
		fetches:     newFetchGroup(),
		rateLimiter: newRateLimiter(),
	}
}

func (s *server) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	start := time.Now()

	route, err := buildRoute(r, s.cfg)
	if err != nil {
		s.respondRouteError(w, r, start, routeLabelFromErrRoute(route), err)
		return
	}

	if route.RouteLabel == "healthz" {
		w.Header().Set("Content-Type", "text/plain; charset=utf-8")
		w.WriteHeader(http.StatusOK)
		_, _ = w.Write([]byte("ok"))
		s.logRequest(r, route.RouteLabel, "BYPASS", http.StatusOK, 0, start, nil)
		return
	}

	if !s.allowRequest(clientIP(r), route, start) {
		http.Error(w, "rate limit exceeded", http.StatusTooManyRequests)
		s.logRequest(r, route.RouteLabel, "REJECTED", http.StatusTooManyRequests, 0, start, nil)
		return
	}

	now := time.Now()
	cached, cachedFound, err := s.cache.Get(route.Kind, route.CacheKey)
	if err != nil {
		http.Error(w, "cache read failed", http.StatusInternalServerError)
		s.logRequest(r, route.RouteLabel, "ERROR", http.StatusInternalServerError, 0, start, err)
		return
	}

	if cachedFound && cached.IsFresh(now) {
		s.writeCachedResponse(w, cached, "HIT", route.CacheKey, 0)
		s.logRequest(r, route.RouteLabel, "HIT", cached.StatusCode, 0, start, nil)
		return
	}

	result, fetchErr := s.fetches.Do(route.CacheKey, func() (*fetchResult, error) {
		return s.fetchAndMaybeCache(route)
	})

	if fetchErr == nil {
		s.writeCachedResponse(w, result.Entry, "MISS", route.CacheKey, result.UpstreamStatus)
		s.logRequest(r, route.RouteLabel, "MISS", result.Entry.StatusCode, result.UpstreamStatus, start, nil)
		return
	}

	if cachedFound && route.AllowStale && allowsStaleFallback(fetchErr) {
		upstreamStatus := extractUpstreamStatus(fetchErr)
		s.writeCachedResponse(w, cached, "STALE", route.CacheKey, upstreamStatus)
		s.logRequest(r, route.RouteLabel, "STALE", cached.StatusCode, upstreamStatus, start, fetchErr)
		return
	}

	if cachedFound && !route.AllowStale {
		_ = s.cache.Delete(route.Kind, route.CacheKey)
	}

	s.respondUpstreamError(w, r, route.RouteLabel, fetchErr, start)
}

func routeLabelFromErrRoute(route *proxyRoute) string {
	if route == nil {
		return "unknown"
	}
	return route.RouteLabel
}

func (s *server) allowRequest(ip string, route *proxyRoute, now time.Time) bool {
	var cfg rateLimit
	switch route.Kind {
	case routeKindSearch:
		cfg = rateLimit{Window: 30 * time.Second, Limit: 15}
	case routeKindLists:
		cfg = rateLimit{Window: 30 * time.Second, Limit: 30}
	case routeKindLevels:
		cfg = rateLimit{Window: 30 * time.Second, Limit: 30}
	case routeKindLevelData:
		cfg = rateLimit{Window: 30 * time.Second, Limit: 20}
	default:
		cfg = rateLimit{Window: 30 * time.Second, Limit: 20}
	}
	return s.rateLimiter.Allow(ip+":"+string(route.Kind), cfg, now)
}

func clientIP(r *http.Request) string {
	if forwarded := strings.TrimSpace(r.Header.Get("X-Forwarded-For")); forwarded != "" {
		parts := strings.Split(forwarded, ",")
		if len(parts) > 0 {
			return strings.TrimSpace(parts[0])
		}
	}
	if realIP := strings.TrimSpace(r.Header.Get("X-Real-IP")); realIP != "" {
		return realIP
	}
	host, _, err := net.SplitHostPort(r.RemoteAddr)
	if err == nil && host != "" {
		return host
	}
	return r.RemoteAddr
}

func (s *server) fetchAndMaybeCache(route *proxyRoute) (*fetchResult, error) {
	req, err := http.NewRequest(route.Method, route.UpstreamURL, strings.NewReader(string(route.UpstreamBody)))
	if err != nil {
		return nil, &upstreamError{Err: err}
	}

	req.Header.Set("User-Agent", s.cfg.UserAgent)
	if route.ContentType != "" {
		req.Header.Set("Content-Type", route.ContentType)
	}

	resp, err := s.httpClient.Do(req)
	if err != nil {
		return nil, &upstreamError{Err: err}
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, &upstreamError{StatusCode: resp.StatusCode, Err: err}
	}

	contentType := strings.TrimSpace(resp.Header.Get("Content-Type"))
	if contentType == "" {
		contentType = "text/plain; charset=utf-8"
	}

	if resp.StatusCode != http.StatusOK {
		return nil, &upstreamError{
			StatusCode:  resp.StatusCode,
			ContentType: contentType,
			Body:        body,
		}
	}

	now := time.Now().UTC()
	entry := &cacheEntry{
		StatusCode:  resp.StatusCode,
		ContentType: contentType,
		BodyBase64:  base64.StdEncoding.EncodeToString(body),
		FetchedAt:   now,
		ExpiresAt:   now.Add(route.CacheTTL),
	}
	if err := s.cache.Save(route.Kind, route.CacheKey, entry); err != nil {
		return nil, err
	}

	return &fetchResult{
		Entry:          entry,
		UpstreamStatus: resp.StatusCode,
	}, nil
}

func (s *server) writeCachedResponse(w http.ResponseWriter, entry *cacheEntry, cacheStatus, cacheKey string, upstreamStatus int) {
	body, err := entry.Body()
	if err != nil {
		http.Error(w, "cached body decode failed", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", entry.ContentType)
	w.Header().Set("X-Proxy-Cache", cacheStatus)
	w.Header().Set("X-Proxy-Cache-Key", shortHash(cacheKey))
	if upstreamStatus > 0 {
		w.Header().Set("X-Proxy-Upstream-Status", strconv.Itoa(upstreamStatus))
	}
	w.WriteHeader(entry.StatusCode)
	_, _ = w.Write(body)
}

func shortHash(value string) string {
	sum := sha256.Sum256([]byte(value))
	return hex.EncodeToString(sum[:8])
}

func extractUpstreamStatus(err error) int {
	var upErr *upstreamError
	if errors.As(err, &upErr) {
		return upErr.StatusCode
	}
	return 0
}

func (s *server) respondRouteError(w http.ResponseWriter, r *http.Request, start time.Time, routeLabel string, err error) {
	var httpErr *httpError
	if errors.As(err, &httpErr) {
		http.Error(w, httpErr.Message, httpErr.Status)
		s.logRequest(r, routeLabel, "REJECTED", httpErr.Status, 0, start, err)
		return
	}
	http.Error(w, "request rejected", http.StatusBadRequest)
	s.logRequest(r, routeLabel, "REJECTED", http.StatusBadRequest, 0, start, err)
}

func (s *server) respondUpstreamError(w http.ResponseWriter, r *http.Request, routeLabel string, err error, start time.Time) {
	var upErr *upstreamError
	if errors.As(err, &upErr) {
		status := upErr.StatusCode
		if status == 0 {
			status = http.StatusBadGateway
		}

		contentType := upErr.ContentType
		if contentType == "" {
			contentType = "text/plain; charset=utf-8"
		}

		w.Header().Set("Content-Type", contentType)
		w.Header().Set("X-Proxy-Cache", "MISS")
		if upErr.StatusCode > 0 {
			w.Header().Set("X-Proxy-Upstream-Status", strconv.Itoa(upErr.StatusCode))
		}
		w.WriteHeader(status)
		if len(upErr.Body) > 0 {
			_, _ = w.Write(upErr.Body)
		} else if upErr.Err != nil {
			_, _ = w.Write([]byte(upErr.Err.Error()))
		} else {
			_, _ = w.Write([]byte("upstream request failed"))
		}

		s.logRequest(r, routeLabel, "ERROR", status, upErr.StatusCode, start, upErr.Err)
		return
	}

	http.Error(w, "upstream request failed", http.StatusBadGateway)
	s.logRequest(r, routeLabel, "ERROR", http.StatusBadGateway, 0, start, err)
}

func (s *server) logRequest(r *http.Request, routeLabel, cacheStatus string, statusCode int, upstreamStatus int, start time.Time, reqErr error) {
	duration := time.Since(start).Milliseconds()
	line := fmt.Sprintf(
		"%s %s route=%s cache=%s status=%d upstream=%d ip=%s duration_ms=%d",
		r.Method,
		r.URL.RequestURI(),
		routeLabel,
		cacheStatus,
		statusCode,
		upstreamStatus,
		clientIP(r),
		duration,
	)
	if reqErr != nil {
		line += fmt.Sprintf(" err=%q", reqErr.Error())
	}
	log.Print(line)
}

func startJanitor(ctx context.Context, store *cacheStore) {
	ticker := time.NewTicker(30 * time.Minute)
	go func() {
		defer ticker.Stop()
		for {
			select {
			case <-ctx.Done():
				return
			case <-ticker.C:
				if err := store.DeleteExpiredLevelEntries(time.Now().UTC()); err != nil {
					log.Printf("level cache cleanup failed: %v", err)
				}
			}
		}
	}()
}

func main() {
	cfg := loadConfig()
	if err := os.MkdirAll(cfg.CacheDir, 0o755); err != nil {
		log.Fatalf("create cache dir: %v", err)
	}

	srv := newServer(cfg)
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	startJanitor(ctx, srv.cache)

	log.Printf("starting PR2Hub proxy on %s (upstream=%s insecure_skip_verify=%t)", cfg.ListenAddr, cfg.UpstreamBase, cfg.InsecureSkipVerify)
	if err := http.ListenAndServe(cfg.ListenAddr, srv); err != nil {
		log.Fatal(err)
	}
}
