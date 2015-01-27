class system::mail (
  $config   = undef,
  $sys_schedule = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  if $config {
    $aliases   = $config['aliases']
    $relayhost = $config['relayhost']
    $type      = $config['type']
  }
  else {
    $hiera_config = hiera_hash('system::mail', undef)
    if $hiera_config {
      $aliases   = $hiera_config['aliases']
      $relayhost = $hiera_config['relayhost']
      $type      = $hiera_config['hiera_config']
    }
  }
  if $aliases {
    create_resources(mailalias, $aliases, $defaults)
  }
  if $relayhost {
    case $type {
      undef, 'postfix': {
        augeas { 'system-mail-postfix-relayhost':
          context  => '/files/etc/postfix/main.cf',
          changes  => [ "set relayhost ${relayhost}" ],
          notify   => Service['postfix'],
          schedule => $sys_schedule,
        }
        service { 'postfix':
          ensure   => 'running',
          enable   => true,
          schedule => $sys_schedule,
        }
      }
      default: {
        fail("type ${type} not supported")
      }
    }
  }
}
