<?php

function replay_insert(
    PDO $pdo,
    string $id,
    int $level_id,
    int $level_version,
    string $mode,
    int $created_at_ms,
    int $duration_ms,
    string $file_path,
    int $file_size,
    ?int $first_finisher_user_id,
    ?int $first_finish_time_ms,
    ?int $first_server_finish_ms,
    int $first_objectives_hit,
    int $best_objectives_hit,
    int $participants_count,
    int $is_pr2hub = 0,
    int $server_id = 0
): void {
    $stmt = $pdo->prepare(
        'INSERT INTO replays
            (id, level_id, is_pr2hub, level_version, mode, created_at_ms, duration_ms,
             first_finisher_user_id, first_finish_time_ms, first_server_finish_ms,
             first_objectives_hit, best_objectives_hit, participants_count,
             file_path, file_size, server_id)
         VALUES
            (:id, :level_id, :is_pr2hub, :level_version, :mode, :created_at_ms, :duration_ms,
             :first_finisher_user_id, :first_finish_time_ms, :first_server_finish_ms,
             :first_objectives_hit, :best_objectives_hit, :participants_count,
             :file_path, :file_size, :server_id)'
    );
    $stmt->execute([
        ':id' => $id,
        ':level_id' => $level_id,
        ':is_pr2hub' => $is_pr2hub,
        ':level_version' => $level_version,
        ':mode' => $mode,
        ':created_at_ms' => $created_at_ms,
        ':duration_ms' => $duration_ms,
        ':first_finisher_user_id' => $first_finisher_user_id,
        ':first_finish_time_ms' => $first_finish_time_ms,
        ':first_server_finish_ms' => $first_server_finish_ms,
        ':participants_count' => $participants_count,
        ':file_path' => $file_path,
        ':file_size' => $file_size,
        ':server_id' => $server_id,
        ':first_objectives_hit' => $first_objectives_hit,
        ':best_objectives_hit' => $best_objectives_hit,
    ]);
}

function replay_participant_insert(
    PDO $pdo,
    string $replay_id,
    int $user_id,
    string $username,
    ?int $hat = null,
    ?int $speed = null,
    ?int $accel = null,
    ?int $jump = null
): void
{
    $stmt = $pdo->prepare(
        'INSERT INTO replay_participants (replay_id, user_id, username, hat, speed, accel, jump)
         VALUES (:replay_id, :user_id, :username, :hat, :speed, :accel, :jump)
         ON DUPLICATE KEY UPDATE
            username = VALUES(username),
            hat = VALUES(hat),
            speed = VALUES(speed),
            accel = VALUES(accel),
            jump = VALUES(jump)'
    );
    $stmt->execute([
        ':replay_id' => $replay_id,
        ':user_id' => $user_id,
        ':username' => $username,
        ':hat' => $hat,
        ':speed' => $speed,
        ':accel' => $accel,
        ':jump' => $jump,
    ]);
}

function replay_participants_select(PDO $pdo, string $replay_id): array
{
    $stmt = $pdo->prepare(
        'SELECT user_id, username, hat, speed, accel, jump
           FROM replay_participants
          WHERE replay_id = :replay_id
          ORDER BY username ASC'
    );
    $stmt->execute([':replay_id' => $replay_id]);
    return $stmt->fetchAll(PDO::FETCH_OBJ);
}

function replay_participants_map_by_replay_ids(PDO $pdo, array $replay_ids): array
{
    if (empty($replay_ids)) {
        return [];
    }

    $placeholders = implode(',', array_fill(0, count($replay_ids), '?'));
    $stmt = $pdo->prepare(
        "SELECT replay_id, user_id, username, hat, speed, accel, jump
           FROM replay_participants
          WHERE replay_id IN ($placeholders)"
    );
    $stmt->execute($replay_ids);
    $rows = $stmt->fetchAll(PDO::FETCH_OBJ);

    $map = [];
    foreach ($rows as $row) {
        $map[$row->replay_id][] = $row;
    }

    return $map;
}

function replay_participants_contains_user(array $participants, int $user_id): bool
{
    if ($user_id <= 0) {
        return false;
    }

    foreach ($participants as $participant) {
        if ((int) ($participant->user_id ?? 0) === $user_id) {
            return true;
        }
    }

    return false;
}

function replay_level_visibility(PDO $pdo, int $level_id, int $is_pr2hub): array
{
    static $cache = [];
    $key = $is_pr2hub . ':' . $level_id;
    if (isset($cache[$key])) {
        return $cache[$key];
    }

    $visibility = [
        'restricted' => false,
        'creator_id' => 0,
    ];

    if ($is_pr2hub === 0 && $level_id > 0) {
        if (!function_exists('level_select')) {
            require_once QUERIES_DIR . '/levels.php';
        }
        $level = level_select($pdo, $level_id, true);
        if ($level !== false) {
            $visibility['creator_id'] = (int) $level->user_id;
            $flag = isset($level->replays_public) ? (int) $level->replays_public : 0;
            $visibility['restricted'] = $flag !== 1;
        }
    }

    $cache[$key] = $visibility;
    return $visibility;
}

function build_solo_participant_key(array $participants): ?string
{
    if (empty($participants)) {
        return null;
    }

    $participant = $participants[0];
    $userId = isset($participant->user_id) ? (int) $participant->user_id : 0;
    $username = strtolower($participant->username ?? '');

    return $userId . ':' . $username;
}

function build_team_participant_key(array $participants): ?string
{
    if (empty($participants)) {
        return null;
    }

    $normalized = array_map(
        static function ($participant) {
            $userId = isset($participant->user_id) ? (int) $participant->user_id : 0;
            $username = strtolower($participant->username ?? '');
            return $userId . ':' . $username;
        },
        $participants
    );

    sort($normalized, SORT_STRING);

    return implode('|', $normalized);
}

function replay_result_insert(
    PDO $pdo,
    string $replay_id,
    int $position,
    int $user_id,
    string $username,
    ?int $finish_time_ms,
    ?int $server_finish_ms,
    int $quit,
    int $objectives_hit
): void {
    $stmt = $pdo->prepare(
        'INSERT INTO replay_results (replay_id, position, user_id, username, finish_time_ms, server_finish_ms, quit, objectives_hit)
         VALUES (:replay_id, :position, :user_id, :username, :finish_time_ms, :server_finish_ms, :quit, :objectives_hit)'
    );
    $stmt->execute([
        ':replay_id' => $replay_id,
        ':position' => $position,
        ':user_id' => $user_id,
        ':username' => $username,
        ':finish_time_ms' => $finish_time_ms,
        ':server_finish_ms' => $server_finish_ms,
        ':quit' => $quit,
        ':objectives_hit' => $objectives_hit,
    ]);
}

function replay_select_by_id(PDO $pdo, string $id)
{
    $stmt = $pdo->prepare('SELECT * FROM replays WHERE id = :id LIMIT 1');
    $stmt->execute([':id' => $id]);
    $row = $stmt->fetch(PDO::FETCH_OBJ);
    if ($row === false) {
        throw new Exception('Replay not found.');
    }
    return $row;
}

function replay_update_hidden(PDO $pdo, string $id, int $hidden, int $staff_user_id)
{
    $hidden = $hidden === 1 ? 1 : 0;
    $hiddenAtMs = $hidden === 1 ? (int) floor(microtime(true) * 1000) : null;
    $hiddenByUserId = $hidden === 1 ? $staff_user_id : null;

    $stmt = $pdo->prepare(
        'UPDATE replays
            SET hidden = :hidden,
                hidden_at_ms = :hidden_at_ms,
                hidden_by_user_id = :hidden_by_user_id
          WHERE id = :id
          LIMIT 1'
    );
    $stmt->bindValue(':hidden', $hidden, PDO::PARAM_INT);
    $stmt->bindValue(':hidden_at_ms', $hiddenAtMs, $hiddenAtMs === null ? PDO::PARAM_NULL : PDO::PARAM_INT);
    $stmt->bindValue(
        ':hidden_by_user_id',
        $hiddenByUserId,
        $hiddenByUserId === null ? PDO::PARAM_NULL : PDO::PARAM_INT
    );
    $stmt->bindValue(':id', $id, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() === 0) {
        $existing = replay_select_by_id($pdo, $id);
        $currentHidden = isset($existing->hidden) ? (int) $existing->hidden : 0;
        if ($currentHidden !== $hidden) {
            throw new Exception('Could not update replay visibility.');
        }
        return $existing;
    }

    return replay_select_by_id($pdo, $id);
}

function replay_results_select(PDO $pdo, string $replay_id): array
{
    $stmt = $pdo->prepare(
        'SELECT position, user_id, username, finish_time_ms, server_finish_ms, quit, objectives_hit
           FROM replay_results
          WHERE replay_id = :replay_id
          ORDER BY position ASC'
    );
    $stmt->execute([':replay_id' => $replay_id]);
    return $stmt->fetchAll(PDO::FETCH_OBJ);
}

function replays_select(
    PDO $pdo,
    ?int $user_id,
    ?int $level_id,
    int $start,
    int $count,
    int $is_pr2hub = 0,
    bool $include_hidden = false
): array {
    $hiddenCondition = $include_hidden ? '' : ' AND COALESCE(r.hidden, 0) = 0';
    $hiddenConditionNoAlias = $include_hidden ? '' : ' AND COALESCE(hidden, 0) = 0';

    if ($user_id !== null) {
        $stmt = $pdo->prepare(
            'SELECT r.*
               FROM replays r
               JOIN replay_participants p ON p.replay_id = r.id
              WHERE p.user_id = :user_id'
                . $hiddenCondition .
            ' AND (r.mode <> \'deathmatch\' OR r.best_objectives_hit > 0)
              ORDER BY r.created_at_ms DESC
              LIMIT :start, :count'
        );
        $stmt->bindValue(':user_id', $user_id, PDO::PARAM_INT);
    } elseif ($level_id !== null) {
        $stmt = $pdo->prepare(
            'SELECT *
               FROM replays
              WHERE level_id = :level_id
                AND is_pr2hub = :is_pr2hub'
                . $hiddenConditionNoAlias .
            ' AND (mode <> \'deathmatch\' OR best_objectives_hit > 0)
              ORDER BY created_at_ms DESC
              LIMIT :start, :count'
        );
        $stmt->bindValue(':level_id', $level_id, PDO::PARAM_INT);
        $stmt->bindValue(':is_pr2hub', $is_pr2hub, PDO::PARAM_INT);
    } else {
        $stmt = $pdo->prepare(
            'SELECT *
               FROM replays
              WHERE 1 = 1'
                . $hiddenConditionNoAlias .
            ' AND (mode <> \'deathmatch\' OR best_objectives_hit > 0)
              ORDER BY created_at_ms DESC
              LIMIT :start, :count'
        );
    }

    $stmt->bindValue(':start', $start, PDO::PARAM_INT);
    $stmt->bindValue(':count', $count, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_OBJ);
}

function replays_leaderboard_by_level(
    PDO $pdo,
    int $level_id,
    int $start,
    int $count,
    int $is_pr2hub = 0,
    ?string $mode_filter = null,
    bool $include_hidden = false
): array {
    $conditions = [
        'level_id = :level_id',
        'is_pr2hub = :is_pr2hub',
        'first_finish_time_ms IS NOT NULL',
        '(mode <> \'deathmatch\' OR best_objectives_hit > 0)',
    ];

    if (!$include_hidden) {
        $conditions[] = 'COALESCE(hidden, 0) = 0';
    }

    if ($mode_filter === 'team') {
        $conditions[] = 'participants_count > 1';
    } elseif ($mode_filter === 'solo') {
        $conditions[] = 'participants_count = 1';
    }

    $sql = sprintf(
        'SELECT *
           FROM replays
          WHERE %s
          ORDER BY best_objectives_hit DESC, first_finish_time_ms ASC, created_at_ms ASC
          LIMIT :start, :count',
        implode(' AND ', $conditions)
    );

    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':level_id', $level_id, PDO::PARAM_INT);
    $stmt->bindValue(':is_pr2hub', $is_pr2hub, PDO::PARAM_INT);
    $stmt->bindValue(':start', $start, PDO::PARAM_INT);
    $stmt->bindValue(':count', $count, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_OBJ);
}

function replays_leaderboard_both(
    PDO $pdo,
    int $level_id,
    int $start,
    int $count,
    int $is_pr2hub = 0,
    bool $include_hidden = false
): array {
    return [
        'solo' => replays_leaderboard_unique_by_type($pdo, $level_id, $start, $count, $is_pr2hub, 'solo', $include_hidden),
        'team' => replays_leaderboard_unique_by_type($pdo, $level_id, $start, $count, $is_pr2hub, 'team', $include_hidden),
    ];
}

function replays_leaderboard_unique_by_type(
    PDO $pdo,
    int $level_id,
    int $start,
    int $count,
    int $is_pr2hub,
    string $type,
    bool $include_hidden = false
): array {
    $type = $type === 'team' ? 'team' : 'solo';
    $target = $start + $count;
    $chunkSize = max(50, $count * 4);
    $rawOffset = 0;

    $uniqueRows = [];
    $seenKeys = [];

    while (count($uniqueRows) < $target) {
        $chunk = replays_leaderboard_fetch_chunk(
            $pdo,
            $level_id,
            $is_pr2hub,
            $type,
            $rawOffset,
            $chunkSize,
            $include_hidden
        );
        if (empty($chunk)) {
            break;
        }

        $replayIds = array_map(static fn($row) => $row->id, $chunk);
        $participantMap = replay_participants_map_by_replay_ids($pdo, $replayIds);

        foreach ($chunk as $row) {
            $participants = $participantMap[$row->id] ?? [];
            $key = $type === 'solo'
                ? build_solo_participant_key($participants)
                : build_team_participant_key($participants);

            if ($key === null || isset($seenKeys[$key])) {
                continue;
            }

            $seenKeys[$key] = true;
            $uniqueRows[] = $row;

            if (count($uniqueRows) >= $target) {
                break;
            }
        }

        $rawOffset += $chunkSize;
    }

    if ($start >= count($uniqueRows)) {
        return [];
    }

    return array_slice($uniqueRows, $start, $count);
}

function replays_leaderboard_fetch_chunk(
    PDO $pdo,
    int $level_id,
    int $is_pr2hub,
    string $type,
    int $start,
    int $count,
    bool $include_hidden = false
): array {
    $participantCondition = $type === 'team' ? 'participants_count > 1' : 'participants_count = 1';
    $hiddenCondition = $include_hidden ? '' : ' AND COALESCE(hidden, 0) = 0';

    $sql = sprintf(
        'SELECT *
           FROM replays
          WHERE level_id = :level_id
            AND is_pr2hub = :is_pr2hub
            %s
            AND first_finish_time_ms IS NOT NULL
            AND %s
            AND (mode <> \'deathmatch\' OR best_objectives_hit > 0)
          ORDER BY best_objectives_hit DESC, first_finish_time_ms ASC, created_at_ms ASC
          LIMIT :start, :count',
        $hiddenCondition,
        $participantCondition
    );

    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':level_id', $level_id, PDO::PARAM_INT);
    $stmt->bindValue(':is_pr2hub', $is_pr2hub, PDO::PARAM_INT);
    $stmt->bindValue(':start', $start, PDO::PARAM_INT);
    $stmt->bindValue(':count', $count, PDO::PARAM_INT);
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_OBJ);
}

function replays_leaderboard_sort_key_expr(string $alias): string
{
    if (!preg_match('/^[a-zA-Z_][a-zA-Z0-9_]*$/', $alias)) {
        throw new Exception('Invalid table alias for leaderboard sort key.');
    }

    $objectives = "GREATEST(0, LEAST(9999999, COALESCE({$alias}.best_objectives_hit, 0)))";
    $finish = "GREATEST(0, LEAST(99999999999, COALESCE({$alias}.first_finish_time_ms, 0)))";
    $created = "GREATEST(0, LEAST(9999999999999, COALESCE({$alias}.created_at_ms, 0)))";

    return "CONCAT(
        LPAD(10000000 - $objectives, 8, '0'),
        LPAD($finish, 11, '0'),
        LPAD($created, 13, '0')
    )";
}

function replays_leaderboard_conditions(string $alias, ?int $is_pr2hub, string $type, bool $include_hidden = false): string
{
    if (!preg_match('/^[a-zA-Z_][a-zA-Z0-9_]*$/', $alias)) {
        throw new Exception('Invalid table alias for leaderboard conditions.');
    }

    $conditions = [
        "{$alias}.first_finish_time_ms IS NOT NULL",
        "({$alias}.mode <> 'deathmatch' OR {$alias}.best_objectives_hit > 0)",
    ];

    if (!$include_hidden) {
        $conditions[] = "COALESCE({$alias}.hidden, 0) = 0";
    }

    if ($type === 'team') {
        $conditions[] = "{$alias}.participants_count > 1";
    } else {
        $conditions[] = "{$alias}.participants_count = 1";
    }

    if ($is_pr2hub !== null) {
        $conditions[] = "{$alias}.is_pr2hub = :is_pr2hub";
    }

    return implode(' AND ', $conditions);
}

function replays_leaderboard_winner_rows(PDO $pdo, ?int $is_pr2hub, string $type, bool $include_hidden = false): array
{
    $type = $type === 'team' ? 'team' : 'solo';

    $outerConditions = replays_leaderboard_conditions('r', $is_pr2hub, $type, $include_hidden);
    $innerConditions = replays_leaderboard_conditions('w', $is_pr2hub, $type, $include_hidden);
    $outerSortKey = replays_leaderboard_sort_key_expr('r');
    $innerSortKey = replays_leaderboard_sort_key_expr('w');

    $winnerSql = "
        SELECT w.level_id, w.is_pr2hub, MIN($innerSortKey) AS sort_key
          FROM replays w
         WHERE $innerConditions
         GROUP BY w.level_id, w.is_pr2hub
    ";

    $sql = "
        SELECT r.*
          FROM replays r
          INNER JOIN ($winnerSql) winners
                  ON winners.level_id = r.level_id
                 AND winners.is_pr2hub = r.is_pr2hub
                 AND $outerSortKey = winners.sort_key
         WHERE $outerConditions
    ";

    $stmt = $pdo->prepare($sql);
    if ($is_pr2hub !== null) {
        $stmt->bindValue(':is_pr2hub', $is_pr2hub, PDO::PARAM_INT);
    }
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_OBJ);
}

function replays_leaderboard_increment_holder(array &$counts, int $userId, string $username): void
{
    if ($userId <= 0) {
        return;
    }
    $username = trim((string) $username);
    if ($username === '') {
        return;
    }
    if (!isset($counts[$userId])) {
        $counts[$userId] = [
            'user_id' => $userId,
            'username' => $username,
            'count' => 0,
        ];
    } elseif ($counts[$userId]['username'] !== $username) {
        $counts[$userId]['username'] = $username;
    }
    $counts[$userId]['count']++;
}

function replays_leaderboard_champion_counts(PDO $pdo, ?int $is_pr2hub, string $type): array
{
    $winnerRows = replays_leaderboard_winner_rows($pdo, $is_pr2hub, $type);
    if (empty($winnerRows)) {
        return [
            'total_levels' => 0,
            'counts' => [],
        ];
    }

    $replayIds = array_map(static fn($row) => $row->id, $winnerRows);
    $participantsMap = replay_participants_map_by_replay_ids($pdo, $replayIds);

    $counts = [];
    foreach ($winnerRows as $row) {
        $participants = $participantsMap[$row->id] ?? [];

        if ($type === 'team') {
            $seen = [];
            foreach ($participants as $participant) {
                $userId = isset($participant->user_id) ? (int) $participant->user_id : 0;
                if ($userId <= 0 || isset($seen[$userId])) {
                    continue;
                }
                $seen[$userId] = true;
                replays_leaderboard_increment_holder($counts, $userId, $participant->username ?? '');
            }
            continue;
        }

        $participant = $participants[0] ?? null;
        if ($participant !== null) {
            $userId = isset($participant->user_id) ? (int) $participant->user_id : 0;
            replays_leaderboard_increment_holder($counts, $userId, $participant->username ?? '');
            continue;
        }

        $fallbackUserId = isset($row->first_finisher_user_id) ? (int) $row->first_finisher_user_id : 0;
        if ($fallbackUserId > 0) {
            replays_leaderboard_increment_holder($counts, $fallbackUserId, 'Unknown');
        }
    }

    return [
        'total_levels' => count($winnerRows),
        'counts' => array_values($counts),
    ];
}
