<?php

function throttle_bans($pdo, $mod_user_id)
{
    $time = (int) (time() - 3600);
  
    $stmt = $pdo->prepare('SELECT COUNT(*) as recent_ban_count FROM bans WHERE mod_user_id = :mod AND time > :time');
    $stmt->bindValue(':mod', $mod_user_id, PDO::PARAM_INT);
    $stmt->bindValue(':time', $time, PDO::PARAM_INT);
    $stmt->execute();
    $row = $stmt->fetchAll(PDO::FETCH_OBJ);
    return $row;
}

function ban_user($pdo, $banned_ip, $banned_user_id, $mod_user_id, $expire_time, $reason, $record, $banned_name, $mod_name, $ip_ban, $account_ban)
{
    $time = (int) time();
    
    // the SQL we want
    $stmt = $pdo->prepare(
        'INSERT INTO bans (banned_ip, banned_user_id, mod_user_id, time, expire_time, reason, record, banned_name, mod_name, ip_ban, account_ban)
						VALUES (:banned_ip, :banned_user_id, :mod_user_id, :time, :expire_time, :reason, :record, :banned_name, :mod_name, :ip_ban, :account_ban)'
    );

    // bind the parameters
    $stmt->bindValue(':banned_ip', $banned_ip, PDO::PARAM_STR);
    $stmt->bindValue(':banned_user_id', $banned_user_id, PDO::PARAM_INT);
    $stmt->bindValue(':mod_user_id', $mod_user_id, PDO::PARAM_INT);
    $stmt->bindValue(':time', $time, PDO::PARAM_INT);
    $stmt->bindValue(':expire_time', $expire_time, PDO::PARAM_INT);
    $stmt->bindValue(':reason', $reason, PDO::PARAM_STR);
    $stmt->bindValue(':record', $record, PDO::PARAM_STR);
    $stmt->bindValue(':banned_name', $banned_name, PDO::PARAM_STR);
    $stmt->bindValue(':mod_name', $mod_name, PDO::PARAM_STR);
    $stmt->bindValue(':ip_ban', $ip_ban, PDO::PARAM_INT);
    $stmt->bindValue(':account_ban', $account_ban, PDO::PARAM_INT);
    
    // execute the PDO and get the results
    $stmt->execute();

    return true;
}