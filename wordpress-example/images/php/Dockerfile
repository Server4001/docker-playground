FROM phusion/baseimage:0.9.17
MAINTAINER Brice Bentler <me@bricebentler.com>

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y python-software-properties
RUN locale-gen en_US.UTF-8 && export LANG=C.UTF-8 && add-apt-repository -y ppa:ondrej/php5-5.6
RUN apt-get update && apt-get install -y php5 php5-dev php5-curl php5-gd php5-mysql php5-mysqlnd php5-fpm php5-memcache php5-xcache php5-mcrypt php5-xdebug php5-ssh2 php5-imagick

COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY php-cli.ini /etc/php5/cli/php.ini
COPY php-fpm.ini /etc/php5/fpm/php.ini
COPY xdebug.ini /etc/php5/mods-available/xdebug.ini

RUN mkdir -p /var/log/php-fpm
RUN ln -sf /dev/stdout /var/log/php-fpm/access.log
RUN ln -sf /dev/stderr /var/log/php-fpm/error.log

RUN mkdir -p /etc/service/php-fpm
ADD start.sh /etc/service/php-fpm/run
RUN chmod +x /etc/service/php-fpm/run

EXPOSE 9000

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
