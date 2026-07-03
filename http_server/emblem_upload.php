<?php

header("Content-type: text/plain");

require_once GEN_HTTP_FNS;

$ip = get_ip();

$ret = new stdClass();
$ret->success = false;

try {
    // POST check
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new Exception("Invalid request method.");
    }

    // check referrer
    require_trusted_ref('upload an emblem');

    // rate limiting
    $rl_msg_sec = 'Please wait at least 15 seconds before trying to upload a guild emblem again.';
    $rl_msg_min = 'Please wait at least 15 minutes before trying to upload a guild emblem again.';
    rate_limit('emblem-upload-attempt-'.$ip, 15, 1, $rl_msg_sec);
    rate_limit('emblem-upload-attempt-'.$ip, 900, 10, $rl_msg_min);

    $image = file_get_contents("php://input");

    // connect to the db
    $pdo = pdo_connect();

    // check their login
    $user_id = token_login($pdo, false);

    // more rate limiting
    rate_limit('emblem-upload-attempt-'.$user_id, 15, 1, $rl_msg_sec);
    rate_limit('emblem-upload-attempt-'.$user_id, 900, 10, $rl_msg_min);

    // get user info
    $account = user_select_expanded($pdo, $user_id);

    // sanity checks
    if ($account->rank < 20) {
        throw new Exception('You must be rank 20 or above to upload an emblem.');
    }
    if ($account->power <= 0) {
        $e = 'Guests can\'t upload guild emblems. To access this feature, please create your own account.';
        throw new Exception($e);
    }
    if ($image === false || $image === '') {
        throw new Exception('No image was received.');
    }
    if (strlen($image) > 20000) {
        throw new Exception('The image is too large. Try uploading a smaller image.');
    }
    if (@getimagesizefromstring($image) === false) {
        throw new Exception('This file is not an image.');
    }

    // Save guild emblems locally so self-hosted installs do not depend on S3.
    $emblems_dir = WWW_ROOT . '/emblems';
    if (!is_dir($emblems_dir) && !mkdir($emblems_dir, 0775, true) && !is_dir($emblems_dir)) {
        throw new Exception('Could not prepare emblem storage.');
    }

    $filename = $user_id . '-' . time() . '.jpg';
    $file_path = $emblems_dir . '/' . $filename;
    $bytes_written = @file_put_contents($file_path, $image, LOCK_EX);
    if ($bytes_written === false || $bytes_written !== strlen($image)) {
        $last_error = error_get_last();
        $details = array(
            'dir' => $emblems_dir,
            'dir_exists' => is_dir($emblems_dir) ? 1 : 0,
            'dir_writable' => is_writable($emblems_dir) ? 1 : 0,
            'path' => $file_path,
            'path_exists' => file_exists($file_path) ? 1 : 0,
            'bytes_expected' => strlen($image),
            'bytes_written' => $bytes_written,
            'php_error' => $last_error['message'] ?? 'unknown',
        );
        error_log('Guild emblem upload failed: ' . json_encode($details));
        throw new Exception('Could not save image. '.json_encode($details));
    }
    if (!is_file($file_path)) {
        $details = array(
            'dir' => $emblems_dir,
            'dir_exists' => is_dir($emblems_dir) ? 1 : 0,
            'dir_writable' => is_writable($emblems_dir) ? 1 : 0,
            'path' => $file_path,
            'path_exists' => file_exists($file_path) ? 1 : 0,
        );
        error_log('Guild emblem upload missing after write: ' . json_encode($details));
        throw new Exception('Could not save image. '.json_encode($details));
    }

    // more rate limiting
    $rl_msg_day = 'You can upload a maximum of two guild emblem images per day. Try again tomorrow.';
    rate_limit('emblem-upload-'.$ip, 86400, 2, $rl_msg_day);
    rate_limit('emblem-upload-'.$user_id, 86400, 2, $rl_msg_day);

    // tell it to the world
    $ret->success = true;
    $ret->len = strlen($image);
    $ret->filename = $filename;
} catch (Exception $e) {
    $ret->error = $e->getMessage();
} finally {
    die(json_encode($ret));
}
