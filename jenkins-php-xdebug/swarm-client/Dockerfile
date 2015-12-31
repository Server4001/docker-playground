FROM php:5.6-cli

ENV XDEBUG_VERSION 2.3.3
ENV XDEBUG_MD5 60e6fdf41840104a23debe16db15a2af
ENV CLIENT_NAME Pakjespiet
ENV EXECUTORS 5
ENV OAUTH_TOKEN <github oauth token>
ENV JENKINS_MASTER http://uri.to.jenkins
ENV SWARM_CLIENT_VERSION 2.0

RUN apt-get update \
        && apt-get install -y sudo default-jre wget git php5-common zlib1g-dev libmcrypt-dev python-pip python-dev libxml2-dev libssl-dev \
        && docker-php-ext-install zip mcrypt bcmath mbstring soap gettext mysqli \
        && rm -rf /var/lib/apt/lists/*

RUN pecl install mongo && echo "extension=mongo.so" >> /usr/local/etc/php/conf.d/mongo.ini

RUN set -x \
    && curl -SL "http://www.xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz" -o xdebug.tgz \
    && echo $XDEBUG_MD5 xdebug.tgz | md5sum -c - \
    && mkdir -p /usr/src/xdebug \
    && tar -xf xdebug.tgz -C /usr/src/xdebug --strip-components=1 \
    && rm xdebug.* \
    && cd /usr/src/xdebug \
    && phpize \
    && ./configure \
    && make -j"$(nproc)" \
    && make install \
    && make clean

COPY /php-conf.d/ext-xdebug.ini /usr/local/etc/php/conf.d/

RUN curl -sS https://getcomposer.org/installer | php --install-dir=/usr/local/bin --filename=composer

COPY /php-conf.d/timezone.ini /usr/local/etc/php/conf.d/timezone.ini

RUN /usr/local/bin/composer config -g github-oauth.github.com $OAUTH_TOKEN
RUN wget http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$SWARM_CLIENT_VERSION/swarm-client-$SWARM_CLIENT_VERSION-jar-with-dependencies.jar

ENTRYPOINT java -jar swarm-client-2.0-jar-with-dependencies.jar -master $JENKINS_MASTER -labels php56 -executors $EXECUTORS -name $CLIENT_NAME
