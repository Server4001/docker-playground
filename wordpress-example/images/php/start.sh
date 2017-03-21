#!/usr/bin/env bash
usermod -u 1000 www-data
php-fpm7.0 -c /etc/php/7.0/fpm/php.ini --fpm-config /etc/php/7.0/fpm/php-fpm.conf
