FROM phusion/baseimage:0.9.17
MAINTAINER Brice Bentler <me@bricebentler.com>

# Prevent dpkg errors
ENV DEBIAN_FRONTEND=noninteractive

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y python-software-properties
RUN locale-gen en_US.UTF-8 && export LANG=C.UTF-8 && add-apt-repository -y ppa:ondrej/php
RUN apt-get update && apt-get install -y php7.0
RUN apt-get install -y php7.0-dev php7.0-curl php7.0-gd php7.0-mysql php7.0-mysqlnd php7.0-fpm php7.0-memcache php7.0-mcrypt php7.0-xdebug php7.0-ssh2 php7.0-imagick

COPY php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY php-cli.ini /etc/php/7.0/cli/php.ini
COPY php-fpm.ini /etc/php/7.0/fpm/php.ini
COPY xdebug.ini /etc/php/7.0/mods-available/xdebug.ini

RUN mkdir -p /var/log/php-fpm
RUN ln -sf /dev/stdout /var/log/php-fpm/access.log
RUN ln -sf /dev/stderr /var/log/php-fpm/error.log

RUN mkdir -p /etc/service/php-fpm && mkdir -p /run/php
ADD start.sh /etc/service/php-fpm/run
RUN chmod +x /etc/service/php-fpm/run

EXPOSE 9000

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
