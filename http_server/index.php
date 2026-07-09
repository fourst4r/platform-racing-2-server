<?php

require_once GEN_HTTP_FNS;
require_once HTTP_FNS . '/output_fns.php';

$socket_proxy_targets = [];
$status_file = __DIR__ . '/files/server_status_2.txt';
if (file_exists($status_file)) {
    $status_data = json_decode(file_get_contents($status_file), true);
    if (!empty($status_data['servers']) && is_array($status_data['servers'])) {
        foreach ($status_data['servers'] as $server) {
            $host = isset($server['address']) ? trim((string) $server['address']) : '';
            $port = isset($server['port']) ? (int) $server['port'] : 0;
            if ($host !== '' && $port > 0) {
                $socket_proxy_targets[] = ['host' => $host, 'port' => $port];
            }
        }
    }
}

if (empty($socket_proxy_targets)) {
    $socket_proxy_targets[] = ['host' => '127.0.0.1', 'port' => 9160];
}

$socket_proxy_targets[] = ['host' => 'localhost', 'port' => 9160];
$request_host = isset($_SERVER['HTTP_HOST']) ? preg_replace('/:\d+$/', '', (string) $_SERVER['HTTP_HOST']) : '';
if (!empty($request_host)) {
    $socket_proxy_targets[] = ['host' => $request_host, 'port' => 9160];
}

$socket_proxy_targets = array_values(array_unique($socket_proxy_targets, SORT_REGULAR));
$socket_proxy_targets_json = json_encode($socket_proxy_targets, JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT);

$head_extras = [
    "<script>(function(){var socketScheme=window.location.protocol==='https:'?'wss://':'ws://';var socketProxyUrl=socketScheme+window.location.host+'/socketproxy/';var targets=$socket_proxy_targets_json;window.RufflePlayer=window.RufflePlayer||{};window.RufflePlayer.config=window.RufflePlayer.config||{};window.RufflePlayer.config.socketProxy=targets.map(function(target){return {host:target.host,port:target.port,proxyUrl:socketProxyUrl};});})();</script>",
    "<script src='https://unpkg.com/@ruffle-rs/ruffle'></script>",
];

output_header('Platform Racing 2', false, false, false, $head_extras);

$swf_path = __DIR__ . '/clients/loader.swf';
$swf_version = file_exists($swf_path) ? (string) filemtime($swf_path) : (string) time();
$swf_url = '/clients/loader.swf?v=' . urlencode($swf_version);

echo '<div class="game_holder">'
        .'<embed width="550" height="400" '
        .'src="' . htmlspecialchars($swf_url, ENT_QUOTES) . '" '
        .'type="application/x-shockwave-flash"></embed>'
    .'</div>';

output_footer();
