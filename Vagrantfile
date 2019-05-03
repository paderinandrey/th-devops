# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_BOX = 'generic/ubuntu1804'
VM_NETWORK = '10.0.0.'

Vagrant.configure('2') do |config|
  config.vm.define 'docker', primary: true do |docker|
    docker.vm.box = VM_BOX
    docker.vm.hostname = 'rails-dev'

    docker.vm.network :private_network, ip: "#{VM_NETWORK}10"
    docker.vm.network 'forwarded_port', guest: 22, host: 2222
    docker.vm.network 'forwarded_port', guest: 80, host: 3000

    public_key = File.read("#{ENV['HOME']}/.ssh/id_rsa.pub")
    script = <<SCRIPT
      echo "#{public_key}" >> /home/vagrant/.ssh/authorized_keys
SCRIPT
    docker.vm.provision :shell, inline: script
  end

  config.vm.define 'db' do |db|
    db.vm.box = VM_BOX
    db.vm.hostname = 'postgres'

    db.vm.network :private_network, ip: "#{VM_NETWORK}11"
    db.vm.network 'forwarded_port', guest: 22, host: 2022

    public_key = File.read("#{ENV['HOME']}/.ssh/id_rsa.pub")
    script = <<SCRIPT
      echo "#{public_key}" >> /home/vagrant/.ssh/authorized_keys
SCRIPT
    db.vm.provision :shell, inline: script
  end
end
