FROM alpine:3.6

MAINTAINER Brice Bentler "me@bricebentler.com"

WORKDIR /application

RUN apk --update add \
    curl \
    php7 \
    php7-common \
    php7-curl \
    php7-dom \
    php7-fpm \
    php7-gd \
    php7-gettext \
    php7-gmp \
    php7-imagick \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-memcached \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pcntl \
    php7-phar \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-posix \
    php7-sqlite3 \
    php7-tokenizer \
    php7-xdebug \
    php7-xml \
    php7-xmlreader \
    php7-xmlrpc \
    php7-xmlwriter \
    php7-zip \
    php7-zlib \
    && rm -rf /var/cache/apk/* \
    # Send access and error logs to Docker log collector.
    && ln -sf /dev/stdout /var/log/php7/access.log \
    && ln -sf /dev/stderr /var/log/php7/error.log \
    && curl -sS https://getcomposer.org/installer | \
        php -d allow_url_fopen=On -- --install-dir=/usr/bin --filename=composer

COPY config/php/php.ini /etc/php7/conf.d/50-setting.ini
COPY config/php/php-fpm.conf /etc/php7/php-fpm.conf
COPY config/php/pool.conf /etc/php7/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm7", "-F"]
