#!/bin/bash
set -euxo pipefail
[[ $EUID -eq 0 ]] || { echo "Run $0 as root or with sudo" >&2; exit 99; }

puppet_major_ver=$(hostname | grep -o -P "\d")

if ! dpkg -s "puppet${puppet_major_ver}-release"; then
  codename=$(awk -F= '/VERSION_CODENAME/ {print $2}' /etc/os-release)
  puppet_release_deb="puppet${puppet_major_ver}-release-${codename}.deb"
  wget "https://apt.puppet.com/${puppet_release_deb}"
  dpkg -i "$puppet_release_deb"
  apt-get update
fi

if ! dpkg -s puppet-agent; then
  apt-get install puppet-agent -y
fi
