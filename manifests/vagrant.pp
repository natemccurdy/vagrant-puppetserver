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
