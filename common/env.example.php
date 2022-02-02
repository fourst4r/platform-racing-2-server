<?php

$BLS_IP_PREFIX = 'test';
$SERVER_IP = '127.0.0.1';

$DEBUG_MODE = true; // always set to false in production environments

$DB_ADDRESS = 'mysql';
$DB_PASS = 'pr2';
$DB_USER = 'pr2';
$DB_NAME = 'pr2';
$DB_PORT = 3306;

$S3_SECRET = 'secret';
$S3_PASS = 'pass';

$PROCESS_PASS = 'abc';
$PROCESS_IP = '127.0.0.1';

$COMM_PASS = 'QHE0NSNwKWZZQVEhU19xMA==';

$EMAIL_HOST = 'ssl://some.emailhost.com';
$EMAIL_PORT = 'port';
$EMAIL_USER = '2@2.com';
$EMAIL_PASS = 'pass';

$PR2_HUB_API_KEY = 'test';
$PR2_HUB_API_ALLOWED_IPS = [
    'an ip',
    'another ip'
];

$IP_API_ENABLED = true;
$IP_API_KEY_1 = 'my secret key';
$IP_API_KEY_2 = 'my super secret key';
$IP_API_LINK_PRE = 'a link pre';
$IP_API_LINK_SUF = 'a link suf';
$IP_API_SCORE_MIN = /* over */ 9000;
$IP_API_LINK_2 = 'another link';

$VAULT_TITLE = '';

$BANNED_IP_PREFIXES = [
    '127.0.0.',
    '192.168.0.'
];

$KONG_API_PASS = 'ghi';

$PAYPAL_SANDBOX = false; // always set to false in production environments
$PAYPAL_API_ENDPOINT = $PAYPAL_SANDBOX ? 'https://api.sandbox.paypal.com' : 'https://api.paypal.com';
$PAYPAL_CLIENT_ID = $PAYPAL_SANDBOX ? 'sandbox client id' : 'production client id';
$PAYPAL_SECRET = $PAYPAL_SANDBOX ? 'sandbox secret' : 'production secret';

$PAYPAL_DATA_KEY = 'elon';
$PAYPAL_DATA_IV = 'musk';

$URL_SALT = '[%B3+WKxQl';
$URL_KEY = 'OTkhX24+S0VVaHlAIXhqbA==';
$URL_IV = 'J1N0QSJzSWV6ZT4mIz5vKA==';

$LEVEL_LIST_SALT = '984cn98c54$';
$LEVEL_SALT = '84ge5tnr';
$LEVEL_SALT_2 = '0kg4%dsw';
$LEVEL_PASS_SALT = 'WGZSL3JWcUE9L3Q4YipZIQ==';
$LEVEL_PASS_KEY = 'OWdCREBKUkI9JjEpQCNuYg==';
$LEVEL_PASS_IV = 'ZiUybmpjc04mNEAkNythbg==';

$LOGIN_KEY = 'VUovam5GKndSMHFSSy9kSA==';
$LOGIN_IV = 'JmM5KnkqNXA9MVVOeC9Ucg==';

$ACCOUNT_CHANGE_KEY = 'KVhFJSVLNigvKkdhV0RaSw==';
$ACCOUNT_CHANGE_IV = 'QEFUZCskMnhhdk8rYlFLKg==';

$ALLOWED_CLIENT_VERSIONS = array('weeeee version', 'weeeee new version', "1-nov-2021-v166");
$FALLBACK_ADDRESSES = array($SERVER_IP);
$TRUSTED_REFS = [ // trusted referrers for the pr2 client
    'http://pr2hub.com/', // pr2hub
    'https://pr2hub.com/', // pr2hub
    'http://www.pr2hub.com/', // pr2hub
    'https://www.pr2hub.com/', // pr2hub
    'http://cdn.jiggmin.com/', // jv
    'http://chat.kongregate.com/', // kong
    'http://external.kongregate-games.com/gamez/', // kong
    'http://game10110.konggames.com/games/Jiggmin/platform-racing-2', // kong
    'http://uploads.ungrounded.net/439000/', // newgrounds
    'https://jiggmin2.com/games/platform-racing-2', // jv2
    'http://naxxol.github.io/' // advanced LE
];
