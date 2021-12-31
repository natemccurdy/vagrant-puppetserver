# -*- mode: ruby -*-
# vi: set ft=ruby :

# Workaround for new Virtualbox pool defaults: https://github.com/oscar-stack/vagrant-auto_network/issues/36
# You may need to 'rm ~/.vagrant.d/auto_network/pool.yaml' as well.
AutoNetwork.default_pool = '192.168.56.0/21'

Vagrant.configure('2') { |config| config.vagrant.plugins = 'oscar' }

Vagrant.configure('2', &Oscar.run(File.expand_path('../config', __FILE__))) if defined? Oscar
