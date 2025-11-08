<?php

header('Content-Type: application/json');

require_once GEN_HTTP_FNS;
require_once QUERIES_DIR . '/replays.php';

$levelParam = default_get('level_id', '');
$page = max(1, (int) default_get('page', 1));
$count = (int) default_get('count', 20);
$includeParticipants = (int) default_get('include_participants', 0) === 1;
$ip = get_ip();

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        throw new Exception('Invalid request method.');
    }

    if ($levelParam === '') {
        throw new Exception('Missing level_id.');
    }

    $count = min(100, max(1, $count));
    $start = ($page - 1) * $count;

    $levelId = 0;
    $isPr2hub = 0;
    if (strpos($levelParam, '8p_') === 0) {
        $levelId = (int) substr($levelParam, 3);
        $isPr2hub = 0;
    } else {
        $levelId = (int) $levelParam;
        $isPr2hub = 1;
    }

    rate_limit("replay-leader-$ip", 10, 5);

    $pdo = pdo_connect();
    $dual = replays_leaderboard_both($pdo, $levelId, $start, $count, $isPr2hub);

    $formatRows = function ($rows) use ($pdo, $includeParticipants) {
        $list = [];
        foreach ($rows as $row) {
            $entry = [
                'id' => $row->id,
                'level_id' => (int) $row->level_id,
                'is_pr2hub' => (int) $row->is_pr2hub,
                'level_version' => (int) $row->level_version,
                'mode' => $row->mode,
                'created_at_ms' => (int) $row->created_at_ms,
                'duration_ms' => (int) $row->duration_ms,
                'participants_count' => (int) $row->participants_count,
                'first_finisher_user_id' => isset($row->first_finisher_user_id) ? (int) $row->first_finisher_user_id : null,
                'first_finish_time_ms' => isset($row->first_finish_time_ms) ? (int) $row->first_finish_time_ms : null,
                'first_server_finish_time_ms' => isset($row->first_server_finish_ms) ? (int) $row->first_server_finish_ms : null,
                'first_objectives_hit' => isset($row->first_objectives_hit) ? (int) $row->first_objectives_hit : 0,
                'best_objectives_hit' => isset($row->best_objectives_hit) ? (int) $row->best_objectives_hit : 0,
            ];

            if ($includeParticipants) {
                $participants = replay_participants_select($pdo, $row->id);
                $entry['participants'] = array_map(static function ($participant) {
                    return [
                        'user_id' => (int) $participant->user_id,
                        'username' => $participant->username,
                    ];
                }, $participants);
            }

            $list[] = $entry;
        }
        return $list;
    };

    echo json_encode([
        'success' => true,
        'page' => $page,
        'count' => [
            'solo' => count($dual['solo']),
            'team' => count($dual['team']),
        ],
        'replays' => [
            'solo' => $formatRows($dual['solo']),
            'team' => $formatRows($dual['team']),
        ]
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
