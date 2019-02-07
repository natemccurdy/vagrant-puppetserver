#!/bin/bash

CHANGES_MADE=0

# Use 512mb of memory
if ! grep -q 'JAVA_ARGS="-Xms512m -Xmx512m' /etc/sysconfig/puppetserver; then

  echo "puppetserver: Setting heap mem to 512m"
  sed -i '/^JAVA_ARGS=/c\JAVA_ARGS="-Xms512m -Xmx512m -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"' /etc/sysconfig/puppetserver

  ((CHANGES_MADE++))
fi

# Use 2 jruby instances
if ! grep -E -q "[^#]max-active-instances: 2" /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf; then

  echo "puppetserver: Setting max-active-instances to 2"
  sed -i '/max-active-instances:/c\    max-active-instances: 2' /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf

  ((CHANGES_MADE++))
fi

if [[ $CHANGES_MADE -gt 0 ]]; then
  echo "Restarting puppetserver to pick up the configuration changes"
  systemctl restart puppetserver
fi
