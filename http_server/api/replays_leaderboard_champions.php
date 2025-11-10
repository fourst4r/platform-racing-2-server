<?php

header('Content-Type: application/json');

require_once GEN_HTTP_FNS;
require_once QUERIES_DIR . '/replays.php';

function format_champion_section(array $stats, int $limit): array
{
    $counts = $stats['counts'] ?? [];
    usort($counts, static function ($a, $b) {
        if ($a['count'] === $b['count']) {
            return strcasecmp($a['username'], $b['username']);
        }
        return $a['count'] < $b['count'] ? 1 : -1;
    });

    $leaders = array_slice($counts, 0, $limit);

    return [
        'total_levels' => (int) ($stats['total_levels'] ?? 0),
        'unique_players' => count($counts),
        'leaders' => array_map(static function ($row) {
            return [
                'user_id' => (int) $row['user_id'],
                'username' => $row['username'],
                'count' => (int) $row['count'],
            ];
        }, $leaders),
    ];
}

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        throw new Exception('Invalid request method.');
    }

    $limit = (int) default_get('limit', 10);
    $limit = max(1, min(100, $limit));

    $includeParam = strtolower(trim((string) default_get('include', 'solo,team')));
    $includeSolo = strpos($includeParam, 'solo') !== false;
    $includeTeam = strpos($includeParam, 'team') !== false;
    if (!$includeSolo && !$includeTeam) {
        $includeSolo = $includeTeam = true;
    }

    $pdo = pdo_connect();

    $response = [
        'success' => true,
        'limit' => $limit,
    ];

    if ($includeSolo) {
        $soloStats = replays_leaderboard_champion_counts($pdo, null, 'solo');
        $response['solo'] = format_champion_section($soloStats, $limit);
    }

    if ($includeTeam) {
        $teamStats = replays_leaderboard_champion_counts($pdo, null, 'team');
        $response['team'] = format_champion_section($teamStats, $limit);
    }

    echo json_encode($response, JSON_UNESCAPED_SLASHES);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
    ], JSON_UNESCAPED_SLASHES);
}
