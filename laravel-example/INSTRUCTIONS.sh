#!/bin/bash

# composer install (try to do this from the dev container at a later point):
docker run --rm -v /vagrant/laravel-example:/app composer:1.4.2 install

# Build production app image:
docker build -f app.prod.Dockerfile -t server4001/laravel-prod:0.1.0 .

# Creating self-signed SSL cert:
openssl genrsa -out dev.dockerubuntu.loc.key 2048
openssl req -new -x509 -key dev.dockerubuntu.loc.key -out dev.dockerubuntu.loc.cert -days 3650 -subj /CN=dev.dockerubuntu.loc
