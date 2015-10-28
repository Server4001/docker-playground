#!/usr/bin/env bash
usermod -u 1000 www-data
php5-fpm -c /etc/php5/fpm/php.ini --fpm-config /etc/php5/fpm/php-fpm.conf
