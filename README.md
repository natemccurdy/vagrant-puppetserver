# Puppetserver in Vagrant

## Getting started

This Vagrant project uses [Oscar](https://github.com/oscar-stack/oscar) to simplify the setup and config of the VM. So you'll need to install the `oscar` Vagrant plugin first:
```
$ vagrant plugin install oscar
```

## Spinning up the VMs

The provisioning scripts for each VM install the latest Puppet 6 or 7 versions at the time you create the VM.

Puppet 7:
```
$ vagrant up server7
$ vagrant up agent7
```

Puppet 6:
```
$ vagrant up server6
$ vagrant up agent6
```
