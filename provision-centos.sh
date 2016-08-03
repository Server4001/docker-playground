#!/usr/bin/env bash

# Bashrc.
sudo cp /vagrant/config/centos/bash/root.bashrc /root/.bashrc
cp /vagrant/config/centos/bash/vagrant.bashrc /home/vagrant/.bashrc

# Install EPEL repo.
sudo yum install -y epel-release

# Install Vim, tree, etc.
sudo yum install -y vim tree git man man-pages

# Install Docker Compose.
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
sudo chown root: /usr/bin/docker-compose
