<?php

namespace pr2\multi;

use PDO;
use Exception;

class ReplayRecorder
{
    private const MAGIC = 'PR2R';
    private const VERSION = "\x01";
    private const FLAGS = "\x00";

    /** @var resource|null */
    private $fh = null;
    private string $path;
    private string $tmpPath;
    private string $baseDir;
    private array $meta;
    private array $results = [];
    private int $startedAtMs;
    private int $lastEventAtMs;
    private bool $open = false;
    private bool $finalized = false;
    private bool $discarded = false;

    public static function nowMs(): int
    {
        return (int) floor(microtime(true) * 1000);
    }

    public static function makeId(int $levelId, int $levelVersion, int $createdAtMs, bool $isPr2hub = false): string
    {
        $prefix = $isPr2hub ? 'hub' : '8p';
        return sprintf('%s_%d_%d_%d', $prefix, $levelId, $levelVersion, $createdAtMs);
    }

    public function __construct(array $meta, ?string $baseDir = null)
    {
        $this->meta = $meta;
        $this->baseDir = $baseDir ?? (WWW_ROOT . '/replays');
        $this->startedAtMs = $meta['created_at_ms'] ?? self::nowMs();
        $this->lastEventAtMs = $this->startedAtMs;

        if (empty($this->meta['participants']) || !is_array($this->meta['participants'])) {
            $this->meta['participants'] = [];
        }
        if (!isset($this->meta['participants_count'])) {
            $this->meta['participants_count'] = count($this->meta['participants']);
        }
        if (!isset($this->meta['mode'])) {
            $this->meta['mode'] = 'race';
        }

        $levelId = (int) ($this->meta['level_id'] ?? 0);
        $levelVersion = (int) ($this->meta['level_version'] ?? 0);
        $isPr2hub = strpos($levelId, '8p_') !== 0;

        if (!is_dir($this->baseDir)) {
            if (!@mkdir($this->baseDir, 0775, true) && !is_dir($this->baseDir)) {
                throw new Exception('ReplayRecorder: unable to create replay base directory.');
            }
        }

        if (empty($this->meta['replay_id'])) {
            $this->meta['replay_id'] = self::makeId($levelId, $levelVersion, $this->startedAtMs, (bool) $isPr2hub);
        }

        $sourceDir = $isPr2hub ? 'pr2hub' : '8p';
        $dir = $this->baseDir . '/' . $sourceDir;
        if (!is_dir($dir)) {
            if (!@mkdir($dir, 0775, true) && !is_dir($dir)) {
                throw new Exception('ReplayRecorder: unable to create replay directory.');
            }
        }

        $levelDir = $dir . '/' . $levelId;
        if (!is_dir($levelDir)) {
            if (!@mkdir($levelDir, 0775, true) && !is_dir($levelDir)) {
                throw new Exception('ReplayRecorder: unable to create replay level directory.');
            }
        }

        $this->path = $levelDir . '/' . $this->meta['replay_id'] . '.pr2r';
        $this->tmpPath = $this->path . '.tmp';
    }

    public function setMetaValue(string $key, $value): void
    {
        $this->meta[$key] = $value;
    }

    public function addParticipant(int $userId, string $username, int $speed, int $acceleration, int $jumping): void
    {
        $this->meta['participants'][] = [
            'user_id' => $userId,
            'username' => $username,
            'speed' => $speed,
            'acceleration' => $acceleration,
            'jumping' => $jumping,
        ];
        $this->meta['participants_count'] = count($this->meta['participants']);
    }

    public function setLevelData(string $levelData, string $format = 'pr2-level-txt', string $compression = 'zlib'): void
    {
        $originalSize = strlen($levelData);
        $hash = md5($levelData);

        $compressed = $compression === 'zlib'
            ? gzcompress($levelData)
            : $levelData;

        if ($compressed === false) {
            throw new Exception('ReplayRecorder: level compression failed.');
        }

        $this->meta['level'] = [
            'format' => $format,
            'compression' => $compression,
            'hash' => $hash,
            'original_size' => $originalSize,
            'compressed_size' => strlen($compressed),
            'data_b64' => base64_encode($compressed)
        ];
    }

    public function start(): void
    {
        if ($this->open || $this->finalized) {
            return;
        }

        $this->fh = @fopen($this->tmpPath, 'wb');
        if ($this->fh === false) {
            throw new Exception('ReplayRecorder: cannot open replay file for writing.');
        }
        $this->open = true;
        $this->writeHeader();
    }

    public function recordPacket(string $packet): void
    {
        if (!$this->open) {
            return;
        }
        $now = self::nowMs();
        $delta = max(0, $now - $this->lastEventAtMs);
        $this->lastEventAtMs = $now;
        $this->writeUVarint($delta);
        $this->writeUVarint(strlen($packet));
        $this->writeRaw($packet);
    }

    public function recordFinishResult(int $position, int $userId, string $username, ?int $finishTimeMs, ?int $serverTimeMs, bool $quit): void
    {
        $this->results[] = [
            'position' => $position,
            'user_id' => $userId,
            'username' => $username,
            'finish_time_ms' => $finishTimeMs,
            'server_finish_ms' => $serverTimeMs,
            'quit' => $quit ? 1 : 0,
        ];
    }

    public function finalize(PDO $pdo): ?string
    {
        if ($this->discarded) {
            return null;
        }

        if ($this->finalized) {
            return $this->meta['replay_id'] ?? null;
        }

        if ($this->open && is_resource($this->fh)) {
            fflush($this->fh);
            fclose($this->fh);
            $this->open = false;
        }

        if (is_file($this->tmpPath)) {
            if (@rename($this->tmpPath, $this->path) === false) {
                $contents = @file_get_contents($this->tmpPath);
                if ($contents !== false) {
                    @file_put_contents($this->path, $contents);
                }
                @unlink($this->tmpPath);
            }
        }

        $replayId = $this->meta['replay_id'] ?? null;
        if ($replayId === null) {
            return null;
        }

        $durationMs = max(0, $this->lastEventAtMs - $this->startedAtMs);
        $fileSize = @filesize($this->path);
        $fileSize = $fileSize === false ? 0 : (int) $fileSize;

        if (!function_exists('replay_insert')) {
            require_once QUERIES_DIR . '/replays.php';
        }

        $first = null;
        foreach ($this->results as $row) {
            if (($row['quit'] ?? 0) === 0 && $row['finish_time_ms'] !== null) {
                $first = $row;
                break;
            }
        }
        if ($first === null) {
            $first = $this->results[0] ?? null;
        }

        replay_insert(
            $pdo,
            $replayId,
            (int) ($this->meta['level_id'] ?? 0),
            (int) ($this->meta['level_version'] ?? 0),
            (string) ($this->meta['mode'] ?? 'race'),
            (int) $this->startedAtMs,
            (int) $durationMs,
            (string) $this->path,
            $fileSize,
            $first ? (int) $first['user_id'] : null,
            $first ? (int) $first['finish_time_ms'] : null,
            $first ? (int) $first['server_finish_ms'] : null,
            (int) ($this->meta['participants_count'] ?? 0),
            (int) ($this->meta['is_pr2hub'] ?? 0),
            (int) ($this->meta['server_id'] ?? 0)
        );

        foreach ($this->meta['participants'] as $participant) {
            $uid = (int) ($participant['user_id'] ?? 0);
            $uname = (string) ($participant['username'] ?? '');
            replay_participant_insert($pdo, $replayId, $uid, $uname);
        }

        foreach ($this->results as $row) {
            replay_result_insert(
                $pdo,
                $replayId,
                (int) $row['position'],
                (int) $row['user_id'],
                (string) $row['username'],
                $row['finish_time_ms'] !== null ? (int) $row['finish_time_ms'] : null,
                $row['server_finish_ms'] !== null ? (int) $row['server_finish_ms'] : null,
                (int) $row['quit']
            );
        }

        $this->finalized = true;
        return $replayId;
    }

    public function discard(): void
    {
        if ($this->finalized) {
            return;
        }

        if ($this->open && is_resource($this->fh)) {
            fflush($this->fh);
            fclose($this->fh);
            $this->open = false;
        }

        @unlink($this->tmpPath);
        @unlink($this->path);

        $this->finalized = true;
        $this->discarded = true;
    }

    private function writeHeader(): void
    {
        $header = [
            'replay_id' => $this->meta['replay_id'],
            'level_id' => (int) ($this->meta['level_id'] ?? 0),
            'is_pr2hub' => (bool) ($this->meta['is_pr2hub'] ?? false),
            'level_version' => (int) ($this->meta['level_version'] ?? 0),
            'mode' => (string) ($this->meta['mode'] ?? 'race'),
            'created_at_ms' => (int) $this->startedAtMs,
            'server_id' => (int) ($this->meta['server_id'] ?? 0),
            'participants' => $this->meta['participants'],
            'encoding' => 'packet-v1',
        ];
        if (isset($this->meta['level'])) {
            $header['level'] = $this->meta['level'];
        }
        if (isset($this->meta['seed'])) {
            $header['seed'] = (int) $this->meta['seed'];
        }
        $json = json_encode($header, JSON_UNESCAPED_SLASHES);
        if ($json === false) {
            throw new Exception('ReplayRecorder: failed to encode header.');
        }
        $payload = self::MAGIC . self::VERSION . self::FLAGS . pack('N', strlen($json)) . $json;
        $this->writeRaw($payload);
    }

    private function writeRaw(string $bytes): void
    {
        if (!$this->open || !is_resource($this->fh)) {
            throw new Exception('ReplayRecorder: file handle not open.');
        }
        $written = fwrite($this->fh, $bytes);
        if ($written === false || $written !== strlen($bytes)) {
            throw new Exception('ReplayRecorder: failed to write bytes.');
        }
    }

    private function writeUVarint(int $value): void
    {
        $buffer = '';
        do {
            $byte = $value & 0x7F;
            $value >>= 7;
            if ($value > 0) {
                $byte |= 0x80;
            }
            $buffer .= chr($byte);
        } while ($value > 0);
        $this->writeRaw($buffer);
    }
}
