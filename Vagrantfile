# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provision 'file', source: 'elasticsearch', destination: 'elasticsearch'
  config.vm.provision 'file', source: 'elasticsearch.yml', destination: 'elasticsearch.yml'
  config.vm.provision 'shell', path: 'bootstrap.sh'

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.cpus = 1
    vb.memory = 1024
  end

  config.vm.define 'es01', autostart: true do |host|
    host.vm.hostname = 'es01'
    host.vm.network 'private_network', ip: '10.20.30.11'
  end

  config.vm.define 'es02', autostart: true do |host|
    host.vm.hostname = 'es02'
    host.vm.network 'private_network', ip: '10.20.30.12'
  end
end
