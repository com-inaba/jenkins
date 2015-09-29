# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "CentOS7_0"

  config.vm.hostname = "jenkins"
  config.vm.network "private_network", ip: "192.168.33.81"
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=644']
end
