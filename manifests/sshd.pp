class system::sshd (
  $config   = undef,
  $sys_schedule = 'always',
  $sync_host_keys = true
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  if $config {
    create_resources(sshd_config, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::sshd', undef)
    if $hiera_config {
      create_resources(sshd_config, $hiera_config, $defaults)
    }
  }
  if $sync_host_keys {
    # From: http://docs.puppetlabs.com/guides/exported_resources.html
    # and https://wiki.xkyle.com/Managing_SSH_Keys_With_Puppet

    # export host key
    $hostonly = regsubst($facts['networking']['fqdn'], "\\.${facts['networking']['domain']}$", '')
    $host_aliases = [ $facts['networking']['ip'], $hostonly ]
    @@sshkey { $facts['networking']['fqdn']:
      ensure       => present,
      host_aliases => $host_aliases,
      type         => 'rsa',
      key          => $facts['ssh']['rsa']['key'],
    }

    # import all other host keys
    Sshkey <<| |>>
  }
}
