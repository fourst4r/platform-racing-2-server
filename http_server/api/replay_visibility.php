<?php

header('Content-Type: application/json');

require_once GEN_HTTP_FNS;
require_once QUERIES_DIR . '/admin_actions.php';
require_once QUERIES_DIR . '/mod_actions.php';
require_once QUERIES_DIR . '/replays.php';

$replayId = trim((string) default_post('replay_id', default_post('id', '')));
$hiddenRaw = default_post('hidden', null);
$ip = get_ip();

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new Exception('Invalid request method.');
    }

    if ($replayId === '') {
        throw new Exception('Missing replay_id.');
    }

    if ($hiddenRaw === null || !in_array((string) $hiddenRaw, ['0', '1'], true)) {
        throw new Exception('Invalid hidden value.');
    }

    rate_limit("api-replay-visibility-$ip", 10, 10);

    $pdo = pdo_connect();
    $staff = check_moderator($pdo, null, false);
    $hidden = (int) $hiddenRaw;

    $existing = replay_select_by_id($pdo, $replayId);
    $currentHidden = isset($existing->hidden) ? (int) $existing->hidden : 0;
    $changed = $currentHidden !== $hidden;
    $updated = $changed ? replay_update_hidden($pdo, $replayId, $hidden, (int) $staff->user_id) : $existing;

    if ($changed) {
        $action = $hidden === 1 ? 'hid' : 'unhid';
        $actionLogFn = (int) $staff->power === 3 ? 'admin_action_insert' : 'mod_action_insert';
        $message = "$staff->name $action replay $replayId from $ip "
            ."{level_id: $updated->level_id, is_pr2hub: $updated->is_pr2hub, hidden: $hidden}";
        $actionLogFn($pdo, $staff->user_id, $message, 'replay-visibility', $ip);
    }

    echo json_encode([
        'success' => true,
        'changed' => $changed,
        'replay' => [
            'id' => $updated->id,
            'level_id' => (int) $updated->level_id,
            'is_pr2hub' => (int) $updated->is_pr2hub,
            'hidden' => isset($updated->hidden) ? (int) $updated->hidden === 1 : $hidden === 1,
            'hidden_at_ms' => isset($updated->hidden_at_ms) && $updated->hidden_at_ms !== null
                ? (int) $updated->hidden_at_ms
                : null,
            'hidden_by_user_id' => isset($updated->hidden_by_user_id) && $updated->hidden_by_user_id !== null
                ? (int) $updated->hidden_by_user_id
                : null,
        ],
    ], JSON_UNESCAPED_SLASHES);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage(),
    ], JSON_UNESCAPED_SLASHES);
}
