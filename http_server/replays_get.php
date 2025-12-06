<?php

header('Content-Type: application/octet-stream');

require_once GEN_HTTP_FNS;
require_once QUERIES_DIR . '/replays.php';

$id = default_get('id', '');
$ip = get_ip();

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        throw new Exception('Invalid request method.');
    }
    if ($id === '') {
        throw new Exception('Missing replay id.');
    }

    rate_limit("replay-dl-$ip", 5, 3);

    $pdo = pdo_connect();
    $row = replay_select_by_id($pdo, $id);

    $visibility = replay_level_visibility($pdo, (int) $row->level_id, (int) $row->is_pr2hub);
    if ($visibility['restricted']) {
        $viewerId = 0;
        $tokenUserId = token_login($pdo, false, true, 'n');
        if ($tokenUserId === false) {
            throw new Exception('You must be signed in to download this replay.');
        }
        $viewerId = (int) $tokenUserId;

        if ($viewerId !== $visibility['creator_id']) {
            $participants = replay_participants_select($pdo, $row->id);
            if (!replay_participants_contains_user($participants, $viewerId)) {
                throw new Exception('You may only download your own replay for this level.');
            }
        }
    }

    if (!isset($row->file_path) || !is_file($row->file_path)) {
        throw new Exception('Replay file is unavailable.');
    }

    $filename = basename($row->file_path);
    $filesize = (int) filesize($row->file_path);

    header('Content-Disposition: attachment; filename="' . $filename . '"');
    header('Content-Length: ' . $filesize);

    $fh = fopen($row->file_path, 'rb');
    if ($fh === false) {
        throw new Exception('Unable to open replay file.');
    }
    fpassthru($fh);
    exit;
} catch (Exception $e) {
    $resp = new stdClass();
    $resp->success = false;
    $resp->error = $e->getMessage();
    echo json_encode($resp);
    exit;
}
