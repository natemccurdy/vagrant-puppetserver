#!/bin/bash

TMP_MODULEPATH="/vagrant/modules"
PUPPET="/opt/puppetlabs/bin/puppet"

MAX_ACTIVE_INSTANCES="2"
JVM_XMS="512m"
JVM_XMX="512m"

rpm -q puppet6-release >/dev/null || sudo rpm -Uvh https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
rpm -q puppet-agent    >/dev/null || yum install -y puppet-agent

systemctl stop puppet

mkdir "$TMP_MODULEPATH" 2>/dev/null

$PUPPET module install theforeman-puppet --version 11.0.0 --modulepath "$TMP_MODULEPATH"

$PUPPET apply --show-diff --modulepath "$TMP_MODULEPATH" -e "
  class { 'puppet':
    server                      => true,                                # Install/manage puppetserver
    server_foreman              => false,                               # Don't integrate/install Foreman
    server_external_nodes       => '',                                  # Don't use Foreman's node ENC.
    server_reports              => 'store',                             # Don't send reports to Foreman.
    runmode                     => 'unmanaged',                         # Don't manage the puppet agent service.
    server_common_modules_path  => ['/etc/puppetlabs/code/modules'],    # Don't create 'common' module paths.
    server_max_active_instances => ${MAX_ACTIVE_INSTANCES},
    server_jvm_min_heap_size    => '${JVM_XMS}',
    server_jvm_max_heap_size    => '${JVM_XMX}',
  }
"
