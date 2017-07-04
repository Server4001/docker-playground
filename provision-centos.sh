#!/bin/bash

PERSISTENT_DATA_DIR=/var/lib/docker-persistant-data

# Bashrc.
cp /vagrant/config/centos/bash/root.bashrc /root/.bashrc
cp /vagrant/config/centos/bash/vagrant.bashrc /home/vagrant/.bashrc

# Install EPEL repo.
yum install -y epel-release

# Install Vim, tree, etc.
yum install -y vim tree git man man-pages

# Install Docker Compose.
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > docker-compose
mv docker-compose /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
chown root: /usr/bin/docker-compose

# Add directory for MySql and Redis data storage.
mkdir ${PERSISTENT_DATA_DIR}
chown vagrant: ${PERSISTENT_DATA_DIR}
