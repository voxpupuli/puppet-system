class system::mail (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
    $aliases   = $config['aliases']
    $relayhost = $config['relayhost']
    $type      = $config['type']
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
