#!/bin/bash

PERSISTENT_DATA_DIR=/var/lib/docker-persistant-data

# Add Docker group.
groupadd docker
usermod -aG docker vagrant

# Add docker repo.
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
cp /vagrant/config/ubuntu/docker.list /etc/apt/sources.list.d/docker.list

# Install docker.
apt-get update
apt-get purge lxc-docker*

apt-get install -y docker-engine

# Install docker-compose.
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > docker-compose
mv docker-compose /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

# Add vim config.
cp /vagrant/config/ubuntu/vimrc /root/.vimrc /home/vagrant/.vimrc

# Add root user bash auto-completion.
cp /vagrant/config/ubuntu/root.bashrc /root/.bashrc

# Add auto-completion for docker-compose.
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > docker-compose
mv docker-compose /etc/bash_completion.d/docker-compose
chmod 644 /etc/bash_completion.d/docker-compose

# Add directory for MySql and Redis data storage.
mkdir ${PERSISTENT_DATA_DIR}
chown vagrant: ${PERSISTENT_DATA_DIR}
