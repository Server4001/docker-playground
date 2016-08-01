#!/usr/bin/env bash
# Add Docker group.
sudo groupadd docker
sudo usermod -aG docker vagrant

# Add docker repo.
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo cp /vagrant/config/ubuntu/docker.list /etc/apt/sources.list.d/docker.list

# Install docker.
sudo apt-get update
sudo apt-get purge lxc-docker*

sudo apt-get install -y docker-engine

# Install docker-compose.
curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add vim config.
cp /vagrant/config/ubuntu/vimrc ~/.vimrc
sudo cp /vagrant/config/ubuntu/vimrc /root/.vimrc

# Add root user bash auto-completion.
sudo cp /vagrant/config/ubuntu/root.bashrc /root/.bashrc

# Add auto-completion for docker-compose.
curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > docker-compose
sudo mv docker-compose /etc/bash_completion.d/docker-compose
sudo chown root:root /etc/bash_completion.d/docker-compose
sudo chmod 644 /etc/bash_completion.d/docker-compose
