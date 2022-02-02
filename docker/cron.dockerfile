FROM php:7.3-cli

# Set up cron jobs
RUN apt-get update && apt-get -y install cron
RUN echo "* * * * * root php /pr2/common/cron/minute.php >> /var/log/cron.log 2>&1" >> /etc/crontab
RUN echo "0 * * * * root php /pr2/common/cron/hourly.php >> /var/log/cron.log 2>&1" >> /etc/crontab
RUN echo "0 0 * * * root php /pr2/common/cron/daily.php >> /var/log/cron.log 2>&1" >> /etc/crontab
RUN echo "0 0 * * 0 root php /pr2/common/cron/weekly.php >> /var/log/cron.log 2>&1" >> /etc/crontab
RUN touch /var/log/cron.log
RUN mkdir /pr2/cache && mkdir /pr2/pid && mkdir /pr2/log

# Copy in php code
COPY config.php /pr2/
COPY common/ /pr2/common
COPY common/env.example.php /pr2/common/env.php
COPY functions/ /pr2/functions
COPY vend/ /pr2/vend

# copy in custom config
COPY docker/prepend_file.ini $PHP_INI_DIR/conf.d/

# install extensions
RUN docker-php-ext-install pdo_mysql sockets

# Run the command on container startup
CMD cron f && tail -f /var/log/cron.log
#CMD cron f && sleep infinity