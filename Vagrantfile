# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.define 'web', primary: true do |web|
    web.vm.box = 'ubuntu/disco64'
    web.vm.hostname = 'rails-dev'

    web.vm.network :private_network, ip: '10.0.0.10'
    config.vm.network 'forwarded_port', guest: 80, host: 3000

    web.vm.provider 'virtualbox' do |v|
      v.memory = 2048
      v.cpus   = 2
    end
  end

  config.vm.define 'postgres' do |db|
    db.vm.box = 'ubuntu/disco64'
    db.vm.hostname = 'postgres'

    db.vm.network :private_network, ip: '10.0.0.11'

    db.vm.provider 'virtualbox' do |v|
      v.memory = 2048
      v.cpus   = 2
    end
  end

  config.vm.provision 'shell', inline: <<-SHELL
    apt-get update
  SHELL
end
