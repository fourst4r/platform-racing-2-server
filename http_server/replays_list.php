<?php

header('Content-Type: application/json');

require_once GEN_HTTP_FNS;
require_once QUERIES_DIR . '/replays.php';

$userId = (int) default_get('user_id', 0);
$levelParam = default_get('level_id', '');
$page = max(1, (int) default_get('page', 1));
$count = (int) default_get('count', 20);
$includeResults = (int) default_get('include_results', 0) === 1;
$includeParticipants = (int) default_get('include_participants', 0) === 1;
$isPr2hubParam = default_get('is_pr2hub', null);
$ip = get_ip();

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        throw new Exception('Invalid request method.');
    }

    $count = min(100, max(1, $count));
    $start = ($page - 1) * $count;

    $levelId = null;
    $isPr2hub = 0;
    if ($levelParam !== '') {
        if (strpos($levelParam, '8p_') === 0) {
            $levelId = (int) substr($levelParam, 3);
            $isPr2hub = 0;
        } else {
            $levelId = (int) $levelParam;
            $isPr2hub = 1;
        }
    }
    if ($isPr2hubParam !== null) {
        $isPr2hub = (int) $isPr2hubParam;
    }

    rate_limit("replay-list-$ip", 10, 5);

    $pdo = pdo_connect();
    $rows = replays_select(
        $pdo,
        $userId > 0 ? $userId : null,
        $levelId,
        $start,
        $count,
        $isPr2hub
    );

    $responseRows = [];
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
            'file_size' => (int) $row->file_size,
            'first_finisher_user_id' => isset($row->first_finisher_user_id) ? (int) $row->first_finisher_user_id : null,
            'first_finish_time_ms' => isset($row->first_finish_time_ms) ? (int) $row->first_finish_time_ms : null,
            'first_server_finish_time_ms' => isset($row->first_server_finish_ms) ? (int) $row->first_server_finish_ms : null,
        ];

        if ($includeResults) {
            $results = replay_results_select($pdo, $row->id);
            $entry['results'] = array_map(static function ($result) {
                return [
                    'position' => (int) $result->position,
                    'user_id' => (int) $result->user_id,
                    'username' => $result->username,
                    'finish_time_ms' => $result->finish_time_ms !== null ? (int) $result->finish_time_ms : null,
                    'server_finish_ms' => $result->server_finish_ms !== null ? (int) $result->server_finish_ms : null,
                    'quit' => (int) $result->quit === 1,
                ];
            }, $results);
        }

        if ($includeParticipants) {
            $participants = replay_participants_select($pdo, $row->id);
            $entry['participants'] = array_map(static function ($participant) {
                return [
                    'user_id' => (int) $participant->user_id,
                    'username' => $participant->username,
                ];
            }, $participants);
        }

        $responseRows[] = $entry;
    }

    echo json_encode([
        'success' => true,
        'page' => $page,
        'count' => count($responseRows),
        'replays' => $responseRows
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
