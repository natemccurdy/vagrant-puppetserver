# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/centos-7'
  config.vm.hostname = 'puppetserver.vagrant'
  config.vm.define :puppetserver

  config.vm.network :private_network, auto_network: true
  config.vm.network 'forwarded_port', guest: 8140, host: 8140

  config.vm.provider 'virtualbox' do |v|
    v.linked_clone = true
    v.memory = '2048'
    v.cpus = '2'
    v.customize ['modifyvm', :id, '--ioapic', 'on']
  end

  # Get some basic OS tools
  config.vm.provision 'shell', inline: 'rpm -q epel-release || yum install -y epel-release'
  config.vm.provision 'shell', inline: 'rpm -q vim-enhanced htop jq || yum install -y vim htop jq'

  # Get the puppetserver YUM repo and install Puppetserver
  config.vm.provision 'shell', inline: 'rpm -q puppet5-release || rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm'
  config.vm.provision 'shell', inline: 'rpm -q puppetserver || yum install -y puppetserver'

  # Tune and configure puppetserver
  config.vm.provision 'shell', path: 'tune_puppetserver.sh'

end
