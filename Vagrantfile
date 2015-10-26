# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.vm.network :private_network, ip: "192.168.35.41"
    config.vm.network :forwarded_port, guest: 22, host: 6291

    # config.vm.provision :shell, path: "provision.sh", privileged: false

    config.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=775,fmode=664"]
    config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 1
    end
end
