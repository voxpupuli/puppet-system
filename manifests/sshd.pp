class system::sshd (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
  Boolean $sync_host_keys    = true
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  include augeasproviders
  create_resources(sshd_config, $config, $defaults)

  if $sync_host_keys {
    # From: http://docs.puppetlabs.com/guides/exported_resources.html
    # and https://wiki.xkyle.com/Managing_SSH_Keys_With_Puppet

    # export host key
    $hostonly = regsubst($::fqdn, "\\.${::domain}$", '')
    $host_aliases = [ $::ipaddress, $hostonly ]
    @@sshkey { $::fqdn:
      ensure       => present,
      host_aliases => $host_aliases,
      type         => 'rsa',
      key          => $::sshrsakey,
    }

    # import all other host keys
    Sshkey <<| |>>
  }
}
