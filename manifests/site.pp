## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##

# The default node definition matches any node lacking a more specific node
# definition. If there are no other node definitions in this file, classes
# and resources declared in the default node definition will be included in
# every node's catalog.
#
# Note that node definitions in this file are merged with node data from the
# Puppet Enterprise console and External Node Classifiers (ENC's).
#
# For more on node definitions, see: https://puppet.com/docs/puppet/latest/lang_node_definitions.html
node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}


## Vagrant Node Definitions ##
#
# These node definitions exist so you can experiment with your Puppet code in Vagrant.
#
#   * master.vagrant - For the most part, you should not change or add anything
#                      to this. It's empty so that your Vagrant master stays neutral and your
#                      Puppet code doesn't risk messing it up.
#
#   * agent.vagrant  - This is where you can add Puppet code to try out on the agent.
#                      You can include a role, or a profile, or any arbitrary Puppet code you want.
#
node 'master.vagrant' {
  # Intentionally left empty
}

# 1. Put the Puppet code you want to test in this node definition.
# 2. SSH to the agent: vagrant ssh agent1
# 3. Become root: sudo -s
# 4. Do a Puppet run: puppet agent -t
node /agent.*\.vagrant/ {


}
