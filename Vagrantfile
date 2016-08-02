# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"
    ubuntu.vm.box_version = "20160208.0.0"

    ubuntu.vm.network :private_network, ip: "192.168.35.41"
    ubuntu.vm.network :forwarded_port, guest: 22, host: 6291, auto_correct: true

    ubuntu.vm.provision :shell, path: "provision-ubuntu.sh", privileged: false

    ubuntu.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=775,fmode=664"]

    ubuntu.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

  config.vm.define "centos" do |centos|
    centos.vm.box = "boxcutter/centos72-docker"
    centos.vm.box_version = "2.0.14"

    centos.vm.network :private_network, ip: "192.168.35.45"
    centos.vm.network :forwarded_port, guest: 22, host: 6292, auto_correct: true

    # centos.vm.provision :shell, path: "provision-centos.sh", privileged: false

    centos.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=777,fmode=777"]

    centos.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end
end
