#!/usr/bin/env bash

# Bashrc.
sudo cp /vagrant/config/centos/bash/root.bashrc /root/.bashrc
cp /vagrant/config/centos/bash/vagrant.bashrc /home/vagrant/.bashrc

# Install EPEL repo.
sudo yum install -y epel-release

# Install Vim, tree, etc.
sudo yum install -y vim tree git man man-pages

# Add Docker group.
sudo groupadd docker
sudo usermod -aG docker vagrant

# Install Docker.
sudo yum install -y docker-io
sudo service docker start
sudo chkconfig docker on

# Install Docker Compose.
curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
sudo chown root: /usr/bin/docker-compose
