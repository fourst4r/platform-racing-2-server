package main

import (
	"net/http"
	"net/url"
	"strings"
	"testing"
	"time"
)

func testConfig() config {
	return config{
		UpstreamBase: "https://pr2hub.com",
		ListTTLs: map[string]time.Duration{
			"campaign":  time.Minute,
			"best":      time.Minute,
			"best_week": time.Minute,
			"newest":    time.Minute,
		},
		SearchTTL:    time.Minute,
		LevelTTL:     time.Hour,
		LevelDataTTL: time.Minute,
	}
}

func TestBuildListRoute(t *testing.T) {
	req, err := http.NewRequest(http.MethodGet, "http://trapwork.org/files/lists/newest/1", nil)
	if err != nil {
		t.Fatal(err)
	}

	route, err := buildRoute(req, testConfig())
	if err != nil {
		t.Fatalf("buildRoute returned error: %v", err)
	}

	if route.Kind != routeKindLists {
		t.Fatalf("expected routeKindLists, got %q", route.Kind)
	}
	if route.CacheKey != "lists:newest:1" {
		t.Fatalf("unexpected cache key %q", route.CacheKey)
	}
	if !route.AllowStale {
		t.Fatal("expected stale to be allowed for list route")
	}
}

func TestBuildSearchRouteNormalizesForm(t *testing.T) {
	body := strings.NewReader("search_str=test&page=2&mode=user&dir=desc&order=date")
	req, err := http.NewRequest(http.MethodPost, "http://trapwork.org/search_levels.php", body)
	if err != nil {
		t.Fatal(err)
	}

	route, err := buildRoute(req, testConfig())
	if err != nil {
		t.Fatalf("buildRoute returned error: %v", err)
	}

	expected := url.Values{
		"dir":        []string{"desc"},
		"mode":       []string{"user"},
		"order":      []string{"date"},
		"page":       []string{"2"},
		"search_str": []string{"test"},
	}.Encode()

	if route.CacheKey != "search:"+expected {
		t.Fatalf("unexpected cache key %q", route.CacheKey)
	}
	if string(route.UpstreamBody) != expected {
		t.Fatalf("unexpected upstream body %q", string(route.UpstreamBody))
	}
	if !route.AllowStale {
		t.Fatal("expected stale to be allowed for search route")
	}
}

func TestBuildSearchRouteIgnoresTokenAndRand(t *testing.T) {
	body := strings.NewReader("order=date&token=abc123&page=1&rand=8652729&dir=desc&mode=user&search_str=bls1999")
	req, err := http.NewRequest(http.MethodPost, "http://trapwork.org/search_levels.php", body)
	if err != nil {
		t.Fatal(err)
	}

	route, err := buildRoute(req, testConfig())
	if err != nil {
		t.Fatalf("buildRoute returned error: %v", err)
	}

	expected := url.Values{
		"dir":        []string{"desc"},
		"mode":       []string{"user"},
		"order":      []string{"date"},
		"page":       []string{"1"},
		"search_str": []string{"bls1999"},
	}.Encode()

	if route.CacheKey != "search:"+expected {
		t.Fatalf("unexpected cache key %q", route.CacheKey)
	}
	if string(route.UpstreamBody) != expected {
		t.Fatalf("unexpected upstream body %q", string(route.UpstreamBody))
	}
}

func TestBuildLevelRouteDisablesStale(t *testing.T) {
	req, err := http.NewRequest(http.MethodGet, "http://trapwork.org/levels/123.txt?version=5", nil)
	if err != nil {
		t.Fatal(err)
	}

	route, err := buildRoute(req, testConfig())
	if err != nil {
		t.Fatalf("buildRoute returned error: %v", err)
	}

	if route.Kind != routeKindLevels {
		t.Fatalf("expected routeKindLevels, got %q", route.Kind)
	}
	if route.AllowStale {
		t.Fatal("expected stale to be disabled for level route")
	}
	if route.UpstreamURL != "https://pr2hub.com/levels/123.txt?version=5" {
		t.Fatalf("unexpected upstream URL %q", route.UpstreamURL)
	}
}

func TestBuildListRouteIgnoresTokenAndRandQuery(t *testing.T) {
	req, err := http.NewRequest(http.MethodGet, "http://trapwork.org/files/lists/newest/1?rand=5463708&token=abc123", nil)
	if err != nil {
		t.Fatal(err)
	}

	route, err := buildRoute(req, testConfig())
	if err != nil {
		t.Fatalf("buildRoute returned error: %v", err)
	}

	if route.CacheKey != "lists:newest:1" {
		t.Fatalf("unexpected cache key %q", route.CacheKey)
	}
	if route.UpstreamURL != "https://pr2hub.com/files/lists/newest/1" {
		t.Fatalf("unexpected upstream URL %q", route.UpstreamURL)
	}
}

func TestBuildLevelDataRouteIgnoresTokenAndRandQuery(t *testing.T) {
	req, err := http.NewRequest(http.MethodGet, "http://trapwork.org/level_data.php?token=abc123&rand=5493332&level_id=6504283", nil)
	if err != nil {
		t.Fatal(err)
	}

	route, err := buildRoute(req, testConfig())
	if err != nil {
		t.Fatalf("buildRoute returned error: %v", err)
	}

	if route.CacheKey != "level_data:6504283" {
		t.Fatalf("unexpected cache key %q", route.CacheKey)
	}
	if route.UpstreamURL != "https://pr2hub.com/level_data.php?level_id=6504283" {
		t.Fatalf("unexpected upstream URL %q", route.UpstreamURL)
	}
}
