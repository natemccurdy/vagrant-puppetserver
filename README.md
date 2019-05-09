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

## Code testing and development with a Control Repository

The root of this repository is a standard Puppet Control Repository (copied from [puppetlabs/control-repo](https://github.com/puppetlabs/control-repo)).

The entire repo is symlinked to the master's Code directory (`/etc/puppetlabs/code/environments/production/`) during provisioning. This allows you to use the Vagrant master and agent to test and develop code in your control repository.

To try out some code on the agent:
1. First bring up both the master and agent in Vagrant: `vagrant up master agent1`
1. Then run `r10k puppetfile install -v` to deploy any modules from your Puppetfile to the `modules/` directory. Note, this requires first installing r10k locally with `gem install r10k`.
1. Add code you want to run to the Agent's node definition in `manifests/vagrant.pp`:

    ```puppet
    node /agent.*\.vagrant/ {

      notify { 'hello world': }

    }
    ```

1.  Run the Puppet agent in the Agent VM:

    ```
    $ vagrant ssh agent1

    [vagrant@agent1 ~]$ sudo -s
    [root@agent1 vagrant]# puppet agent -t
    Info: Using configured environment 'production'
    Info: Retrieving pluginfacts
    Info: Retrieving plugin
    Info: Retrieving locales
    Info: Loading facts
    Info: Caching catalog for agent1.vagrant
    Info: Applying configuration version '1557423322'
    Notice: hello world
    Notice: /Stage[main]/Main/Node[__node_regexp__agent..vagrant]/Notify[hello world]/message: defined 'message' as 'hello world'
    Notice: Applied catalog in 0.01 seconds
    ```

