FROM php:8.2-apache

# Copy in php code
COPY config.php /pr2/
COPY composer.json /pr2/
COPY composer.lock /pr2/
COPY common/ /pr2/common
COPY functions/ /pr2/functions
COPY http_server/ /pr2/http_server
COPY vend/ /pr2/vend
COPY common/env.example.php /pr2/common/env.php
COPY docker/http_server_startup.sh /http_server_startup.sh

# Copy in custom config
COPY docker/prepend_file.ini $PHP_INI_DIR/conf.d/
COPY docker/pr2hub_proxy.conf /etc/apache2/conf-available/pr2hub_proxy.conf

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Move web root
ENV APACHE_DOCUMENT_ROOT=/pr2/http_server
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Install system dependencies
RUN apt-get update && apt-get install -y \
    zip \
    cron

ENV PR2HUB_PROXY_URL=http://pr2hub-proxy:8080

# Install extensions
RUN docker-php-ext-install pdo_mysql

# Install pecl extensions
RUN pear config-set php_ini "$PHP_INI_DIR/php.ini" \
    && pecl install apcu-5.1.23 \
    && docker-php-ext-enable apcu

# Install composer dependencies
RUN cd /pr2 \
    && curl -sS https://getcomposer.org/installer | php \
    && php composer.phar install --no-dev --optimize-autoloader

# Create a cron file that runs minute.php every minute
COPY docker/minute-cron /etc/cron.d/minute-cron
# Ensure LF endings (Windows checkouts can break cron) and correct perms
RUN sed -i 's/\r$//' /etc/cron.d/minute-cron \
    && chmod 0644 /etc/cron.d/minute-cron

# Ensure cron logs to stdout 
RUN ln -sf /proc/1/fd/1 /var/log/cron.log

# Enable reverse proxy support for same-origin PR2Hub forwarding.
RUN a2enmod proxy proxy_http env \
    && a2enconf pr2hub_proxy

# Run minute and hour cron when this service starts up to generate server and level list files
ENTRYPOINT []
CMD service cron start && /http_server_startup.sh
