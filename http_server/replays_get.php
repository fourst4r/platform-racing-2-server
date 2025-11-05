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
