#!/bin/sh

mkdir -p /pr2/shared/emblems
chown -R www-data:www-data /pr2/shared/emblems
chmod 0775 /pr2/shared/emblems
if [ ! -e /pr2/http_server/emblems ]; then
    ln -s /pr2/shared/emblems /pr2/http_server/emblems
fi

php /pr2/common/cron/minute.php
php /pr2/common/cron/hourly.php
exec apache2-foreground
