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
    int $participants_count,
    int $is_pr2hub = 0,
    int $server_id = 0
): void {
    $stmt = $pdo->prepare(
        'INSERT INTO replays
            (id, level_id, is_pr2hub, level_version, mode, created_at_ms, duration_ms,
             first_finisher_user_id, first_finish_time_ms, first_server_finish_ms, participants_count,
             file_path, file_size, server_id)
         VALUES
            (:id, :level_id, :is_pr2hub, :level_version, :mode, :created_at_ms, :duration_ms,
             :first_finisher_user_id, :first_finish_time_ms, :first_server_finish_ms, :participants_count,
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
    ]);
}

function replay_participant_insert(PDO $pdo, string $replay_id, int $user_id, string $username): void
{
    $stmt = $pdo->prepare(
        'INSERT INTO replay_participants (replay_id, user_id, username)
         VALUES (:replay_id, :user_id, :username)
         ON DUPLICATE KEY UPDATE username = VALUES(username)'
    );
    $stmt->execute([
        ':replay_id' => $replay_id,
        ':user_id' => $user_id,
        ':username' => $username,
    ]);
}

function replay_participants_select(PDO $pdo, string $replay_id): array
{
    $stmt = $pdo->prepare(
        'SELECT user_id, username
           FROM replay_participants
          WHERE replay_id = :replay_id
          ORDER BY username ASC'
    );
    $stmt->execute([':replay_id' => $replay_id]);
    return $stmt->fetchAll(PDO::FETCH_OBJ);
}

function replay_result_insert(
    PDO $pdo,
    string $replay_id,
    int $position,
    int $user_id,
    string $username,
    ?int $finish_time_ms,
    ?int $server_finish_ms,
    int $quit
): void {
    $stmt = $pdo->prepare(
        'INSERT INTO replay_results (replay_id, position, user_id, username, finish_time_ms, server_finish_ms, quit)
         VALUES (:replay_id, :position, :user_id, :username, :finish_time_ms, :server_finish_ms, :quit)'
    );
    $stmt->execute([
        ':replay_id' => $replay_id,
        ':position' => $position,
        ':user_id' => $user_id,
        ':username' => $username,
        ':finish_time_ms' => $finish_time_ms,
        ':server_finish_ms' => $server_finish_ms,
        ':quit' => $quit,
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

function replay_results_select(PDO $pdo, string $replay_id): array
{
    $stmt = $pdo->prepare(
        'SELECT position, user_id, username, finish_time_ms, server_finish_ms, quit
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
    int $is_pr2hub = 0
): array {
    if ($user_id !== null) {
        $stmt = $pdo->prepare(
            'SELECT r.*
               FROM replays r
               JOIN replay_participants p ON p.replay_id = r.id
              WHERE p.user_id = :user_id
              ORDER BY r.created_at_ms DESC
              LIMIT :start, :count'
        );
        $stmt->bindValue(':user_id', $user_id, PDO::PARAM_INT);
    } elseif ($level_id !== null) {
        $stmt = $pdo->prepare(
            'SELECT *
               FROM replays
              WHERE level_id = :level_id
                AND is_pr2hub = :is_pr2hub
              ORDER BY created_at_ms DESC
              LIMIT :start, :count'
        );
        $stmt->bindValue(':level_id', $level_id, PDO::PARAM_INT);
        $stmt->bindValue(':is_pr2hub', $is_pr2hub, PDO::PARAM_INT);
    } else {
        $stmt = $pdo->prepare(
            'SELECT *
               FROM replays
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
    ?string $mode_filter = null
): array {
    $conditions = [
        'level_id = :level_id',
        'is_pr2hub = :is_pr2hub',
        'first_finish_time_ms IS NOT NULL',
    ];

    if ($mode_filter === 'team') {
        $conditions[] = 'participants_count > 1';
    } elseif ($mode_filter === 'solo') {
        $conditions[] = 'participants_count = 1';
    }

    $sql = sprintf(
        'SELECT *
           FROM replays
          WHERE %s
          ORDER BY first_finish_time_ms ASC, created_at_ms ASC
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
    int $is_pr2hub = 0
): array {
    $baseSql = 'SELECT *
                  FROM replays
                 WHERE level_id = :level_id
                   AND is_pr2hub = :is_pr2hub
                   AND first_finish_time_ms IS NOT NULL
                   AND %s
                 ORDER BY first_finish_time_ms ASC, created_at_ms ASC
                 LIMIT :start, :count';

    $soloSql = sprintf($baseSql, 'participants_count = 1');
    $teamSql = sprintf($baseSql, 'participants_count > 1');

    $soloStmt = $pdo->prepare($soloSql);
    $soloStmt->bindValue(':level_id', $level_id, PDO::PARAM_INT);
    $soloStmt->bindValue(':is_pr2hub', $is_pr2hub, PDO::PARAM_INT);
    $soloStmt->bindValue(':start', $start, PDO::PARAM_INT);
    $soloStmt->bindValue(':count', $count, PDO::PARAM_INT);
    $soloStmt->execute();

    $teamStmt = $pdo->prepare($teamSql);
    $teamStmt->bindValue(':level_id', $level_id, PDO::PARAM_INT);
    $teamStmt->bindValue(':is_pr2hub', $is_pr2hub, PDO::PARAM_INT);
    $teamStmt->bindValue(':start', $start, PDO::PARAM_INT);
    $teamStmt->bindValue(':count', $count, PDO::PARAM_INT);
    $teamStmt->execute();

    return [
        'solo' => $soloStmt->fetchAll(PDO::FETCH_OBJ),
        'team' => $teamStmt->fetchAll(PDO::FETCH_OBJ),
    ];
}
