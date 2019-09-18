# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') { |config| config.vagrant.plugins = 'oscar' }

Vagrant.configure('2', &Oscar.run(File.expand_path('../config', __FILE__))) if defined? Oscar
