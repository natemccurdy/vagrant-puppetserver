#!/bin/bash
set -euxo pipefail
[[ $EUID -eq 0 ]] || { echo "Run $0 as root or with sudo" >&2; exit 99; }

source /etc/profile.d/puppet-agent.sh
case $(facter os.family) in
  Debian)
    defaults="/etc/default/puppetserver" ;;
  RedHat)
    defaults="/etc/sysconfig/puppetserver" ;;
  *)
    echo "OS $(facter.os.family) not supported"; exit 98 ;;
esac

CHANGES_MADE=0

# Use 512mb of memory
if ! grep -q 'JAVA_ARGS="-Xms512m -Xmx512m' $defaults; then

  echo "puppetserver: Setting heap mem to 512m"
  sed -i '/^JAVA_ARGS=/c\JAVA_ARGS="-Xms512m -Xmx512m -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"' $defaults

  ((++CHANGES_MADE))
fi

# Use 2 jruby instances
if ! grep -E -q "[^#]max-active-instances: 2" /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf; then

  echo "puppetserver: Setting max-active-instances to 2"
  sed -i '/max-active-instances:/c\    max-active-instances: 2' /etc/puppetlabs/puppetserver/conf.d/puppetserver.conf

  ((++CHANGES_MADE))
fi

if [[ $CHANGES_MADE -gt 0 ]]; then
  echo "Restarting puppetserver to pick up the configuration changes"
  systemctl restart puppetserver
fi
