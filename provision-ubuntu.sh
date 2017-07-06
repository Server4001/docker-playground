#!/bin/bash

PERSISTENT_DATA_DIR=/var/lib/docker-persistant-data

# Remove old docker (if present).
apt-get update
apt-get purge lxc-docker* docker docker-engine docker.io

# Install docker pre-reqs.
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common

# Add the docker GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the docker stable repo.
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install docker ce.
apt-get update
apt-get install -y docker-ce=17.06.0~ce-0~ubuntu

# Install docker-compose.
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > docker-compose
mv docker-compose /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

# Add vim config.
cp /vagrant/config/ubuntu/vimrc /root/.vimrc
cp /vagrant/config/ubuntu/vimrc /home/vagrant/.vimrc
chown vagrant: /home/vagrant/.vimrc

# Add bash auto-completion.
cp /vagrant/config/ubuntu/root.bashrc /root/.bashrc
cp /vagrant/config/ubuntu/vagrant.bashrc /home/vagrant/.bashrc

# Add auto-completion for docker-compose.
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > docker-compose
mv docker-compose /etc/bash_completion.d/docker-compose
chmod 644 /etc/bash_completion.d/docker-compose

# Add vagrant user to docker group.
usermod -aG docker vagrant

# Add directory for MySql and Redis data storage.
mkdir ${PERSISTENT_DATA_DIR}
chown vagrant: ${PERSISTENT_DATA_DIR}
