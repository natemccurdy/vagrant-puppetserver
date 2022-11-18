#!/bin/sh

# Usage
if [ $# -ne 2 ] || [ ! -d "$1" ] || [ ! -d "$1/$2" ]; then
  echo "usage: $0 <environmentpath> <environment>" >&2
  exit 1
fi

# For portability, identify a preferred ruby executable to use
ruby() {
  if [ -x /opt/puppetlabs/puppet/bin/ruby ]; then
    /opt/puppetlabs/puppet/bin/ruby "$@"
  else
    /usr/bin/env ruby "$@"
  fi
}

# Determine how best to calculate a config_version
if [ -e "$1/$2/.r10k-deploy.json" ]; then
  # The environment was deployed using r10k. We will calculate the config
  # version using the r10k data.
  ruby "$1/$2/scripts/config_version-r10k.rb" "$1" "$2"

elif [ -e /opt/puppetlabs/server/pe_version ]; then
  # This is a Puppet Enterprise system and we can rely on the rugged ruby gem
  # being available.
  ruby "$1/$2/scripts/config_version-rugged.rb" "$1" "$2"

elif type git >/dev/null 2>&1 && [ -d "$1/$2/.git" ]; then
  # The git command is available.
  git --git-dir "$1/$2/.git" rev-parse HEAD

else
  # Nothing else available; just use the date.
  date +%s

fi
