<?php

require_once GEN_HTTP_FNS;
require_once HTTP_FNS . '/output_fns.php';
require_once QUERIES_DIR . '/replays.php';

function merge_replay_champion_counts(array $soloStats, array $teamStats): array
{
    $leaders = [];

    foreach ($soloStats['counts'] ?? [] as $row) {
        $userId = (int) ($row['user_id'] ?? 0);
        if ($userId <= 0) {
            continue;
        }

        if (!isset($leaders[$userId])) {
            $leaders[$userId] = [
                'user_id' => $userId,
                'username' => $row['username'] ?? 'Unknown',
                'solo_count' => 0,
                'team_count' => 0,
                'total_count' => 0,
            ];
        }

        $count = (int) ($row['count'] ?? 0);
        $leaders[$userId]['username'] = $row['username'] ?? $leaders[$userId]['username'];
        $leaders[$userId]['solo_count'] = $count;
        $leaders[$userId]['total_count'] += $count;
    }

    foreach ($teamStats['counts'] ?? [] as $row) {
        $userId = (int) ($row['user_id'] ?? 0);
        if ($userId <= 0) {
            continue;
        }

        if (!isset($leaders[$userId])) {
            $leaders[$userId] = [
                'user_id' => $userId,
                'username' => $row['username'] ?? 'Unknown',
                'solo_count' => 0,
                'team_count' => 0,
                'total_count' => 0,
            ];
        }

        $count = (int) ($row['count'] ?? 0);
        $leaders[$userId]['username'] = $row['username'] ?? $leaders[$userId]['username'];
        $leaders[$userId]['team_count'] = $count;
        $leaders[$userId]['total_count'] += $count;
    }

    $leaders = array_values($leaders);
    usort($leaders, static function ($a, $b) {
        if ($a['total_count'] !== $b['total_count']) {
            return $a['total_count'] < $b['total_count'] ? 1 : -1;
        }
        if ($a['solo_count'] !== $b['solo_count']) {
            return $a['solo_count'] < $b['solo_count'] ? 1 : -1;
        }
        if ($a['team_count'] !== $b['team_count']) {
            return $a['team_count'] < $b['team_count'] ? 1 : -1;
        }
        return strcasecmp($a['username'], $b['username']);
    });

    return $leaders;
}

$start = max(0, (int) default_get('start', 0));
$count = max(1, (int) default_get('count', 100));
$ip = get_ip();

try {
    // rate limiting
    rate_limit('leaderboard-'.$ip, 5, 2);

    // connect
    $pdo = pdo_connect();

    // header, also check if mod and output the mod links if so
    $staff = is_staff($pdo, token_login($pdo, true, true, 'g'), false);
    output_header('Leaderboard', $staff->mod, $staff->admin);

    // limit amount of entries to be obtained from the db at a time
    if ($staff->mod === true) {
        $count = ($count - $start) > 100 ? 100 : $count;
    } elseif ($staff->mod === false) {
        $rl_msg = 'Please wait at least one minute before trying to view the leaderboard again.';
        rate_limit('leaderboard-'.$ip, 60, 10, $rl_msg);
        $count = ($count - $start) > 50 ? 50 : $count;
    } else {
        throw new Exception('Could not determine user staff boolean.');
    }

    $soloStats = replays_leaderboard_champion_counts($pdo, null, 'solo');
    $teamStats = replays_leaderboard_champion_counts($pdo, null, 'team');
    $leaders = merge_replay_champion_counts($soloStats, $teamStats);
    $pageLeaders = array_slice($leaders, $start, $count);
    $isEnd = ($start + count($pageLeaders)) >= count($leaders);

    echo '<center>'
        .'<font face="Gwibble" class="gwibble">-- Leaderboard --</font>'
        .'<br /><br />'
        .'Ranking by total #1 replay spots owned across all replay leaderboards.'
        .'<br /><br />'
        .'<table>'
        .'<tr>'
        .'<th>#</th>'
        .'<th>Username</th>'
        .'<th>#1 Replay Spots</th>'
        .'<th>Solo #1s</th>'
        .'<th>Team #1s</th>'
        .'</tr>';

    // get row number
    $i = $start;
    foreach ($pageLeaders as $leader) {
        // increment row number
        $i++;

        // name
        $name = $leader['username'];
        $safe_name = htmlspecialchars($name, ENT_QUOTES);
        $safe_name = str_replace(' ', "&nbsp;", $safe_name);
        $totalCount = (int) $leader['total_count'];
        $soloCount = (int) $leader['solo_count'];
        $teamCount = (int) $leader['team_count'];

        // player details link
        $url_name = urlencode($name);
        if ($staff->admin === true) {
            $info_link = "/admin/player_deep_info.php?name1=$url_name";
        } elseif ($staff->mod === true) {
            $info_link = "/mod/player_info.php?name=$url_name";
        } else {
            $info_link = "player_search.php?name=$url_name";
        }

        // echo the row
        echo '<tr>'
            ."<td>$i</td>"
            ."<td><a href='$info_link' style='text-decoration: underline;'>$safe_name</a></td>"
            ."<td>$totalCount</td>"
            ."<td>$soloCount</td>"
            ."<td>$teamCount</td>"
            .'</tr>';
    }

    echo "</table>";
    output_pagination($start, $count, '', $isEnd);
    echo "</center>";
} catch (Exception $e) {
    output_error_page($e->getMessage(), @$staff);
} finally {
    output_footer();
}
