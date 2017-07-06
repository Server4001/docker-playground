FROM nginx:1.13.1-alpine

MAINTAINER Brice Bentler "me@bricebentler.com"

COPY ./public /application/public

ADD config/nginx/nginx.prod.conf /etc/nginx/nginx.conf
ADD config/nginx/prod.web.conf /etc/nginx/conf.d/default.conf
