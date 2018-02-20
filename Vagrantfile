# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_version = "20160208.0.0"

  config.vm.network :private_network, ip: "192.168.35.41"
  config.vm.network :forwarded_port, guest: 22, host: 6291, auto_correct: true

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.provision :shell, path: "provision-ubuntu.sh", privileged: true
  config.vm.hostname = "dev.dockerubuntu.loc"

  config.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=777,fmode=777"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
end
