<?php

require_once GEN_HTTP_FNS;

header('Content-Type: application/json');

global $PR2_HUB_API_KEY;
if (($_SERVER['HTTP_X_API_TOKEN'] ?? '') !== $PR2_HUB_API_KEY) {
    http_response_code(403);
    echo json_encode(['error' => 'Forbidden']);
    exit;
}

// usernames=oxen,a2,a3
$raw = $_POST['usernames'] ?? '';
$usernames = array_filter(array_map('trim', explode(',', $raw)));

$part_types_raw = $_POST['part_types'] ?? ($_POST['part_type'] ?? '');
$part_types = array_filter(array_map('trim', explode(',', $part_types_raw)));
$part_id   = isset($_POST['part_id']) ? (int)$_POST['part_id'] : 0;

if (empty($usernames) || empty($part_types) || !$part_id) {
    http_response_code(400);
    echo json_encode(['error' => 'Missing parameters.']);
    exit;
}

$results = [];
$pdo = pdo_connect();
foreach ($usernames as $username) {
    $results[$username] = [];
    foreach ($part_types as $part_type) {
        try {
            $results[$username][$part_type] = award_epic_part_to_user($pdo, $username, $part_type, $part_id);
        } catch (Exception $e) {
            $results[$username][$part_type] = 'Error: ' . $e->getMessage();
        }
    }
}

echo json_encode(['results' => $results]);