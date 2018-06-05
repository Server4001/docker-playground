#!/bin/bash

PERSISTENT_DATA_DIR=/var/lib/docker-persistant-data

apt-get update

apt show software-properties-common > /dev/null 2>&1
if [ $? -ne 0 ]; then
  # Install docker pre-reqs.
  apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common
fi

if [ `apt-key list | grep -ic docker` -lt 1 ]; then
  # Add the docker GPG key.
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
fi

if [ `apt-cache policy | grep -c download.docker.com` -lt 1 ]; then
  # Add the docker stable repo.
  add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
fi

if [ ! -f /usr/bin/docker ]; then
  # Install docker ce.
  apt-get update
#  apt-get install -y docker-ce=17.06.0~ce-0~ubuntu
  apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
fi

if [ ! -f /usr/bin/docker-compose ]; then
  # Install docker-compose.
  curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > docker-compose
  mv docker-compose /usr/bin/docker-compose
  chmod +x /usr/bin/docker-compose
fi

# Add vim config.
cp /vagrant/config/vimrc /root/.vimrc
cp /vagrant/config/vimrc /home/vagrant/.vimrc
chown vagrant: /home/vagrant/.vimrc

# Add bash auto-completion.
cp /vagrant/config/root.bashrc /root/.bashrc
cp /vagrant/config/vagrant.bashrc /home/vagrant/.bashrc

if [ ! -f /etc/bash_completion.d/docker-compose ]; then
  # Add auto-completion for docker-compose.
  curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose > docker-compose
  mv docker-compose /etc/bash_completion.d/docker-compose
  chmod 644 /etc/bash_completion.d/docker-compose
fi

if [ `groups vagrant | grep -c docker` -lt 1 ]; then
  # Add vagrant user to docker group.
  usermod -aG docker vagrant
fi

# Add directory for MySql and Redis data storage.
mkdir -p ${PERSISTENT_DATA_DIR}
chown vagrant: ${PERSISTENT_DATA_DIR}

# Install k8s
if [ `apt-key list | grep -c google` -lt 1 ]; then
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
fi

if [ ! -f /etc/apt/sources.list.d/kubernetes.list ]; then
  echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >/etc/apt/sources.list.d/kubernetes.list
fi

if [ ! -f /usr/bin/kubelet ] || [ ! -f /usr/bin/kubeadm ] || [ ! -f /usr/bin/kubectl ]; then
  apt-get update
  apt-get install -y kubelet kubeadm kubectl
#  sed -i "s/--kubeconfig=\/etc\/kubernetes\/kubelet.conf/--kubeconfig=\/etc\/kubernetes\/kubelet.conf --cgroup-driver=cgroupfs/" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
#  systemctl daemon-reload
#  systemctl restart kubelet


  kubeadm init
fi

if [ ! -f /home/vagrant/.kube/config ]; then
  mkdir -p /home/vagrant/.kube
  cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
  chown -R vagrant:vagrant /home/vagrant/.kube
fi

# You should now deploy a pod network to the cluster.
# Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
#   https://kubernetes.io/docs/concepts/cluster-administration/addons/
# You can now join any number of machines by running the following on each node
# as root:
#   kubeadm join 10.0.2.15:6443 --token xazcn1.mcd4cqvuirxnsqv5 --discovery-token-ca-cert-hash sha256:146834e70c86861ce84a90304407f1f0d6d0219dfd9f3fc3ded559c4a8c76ed0
