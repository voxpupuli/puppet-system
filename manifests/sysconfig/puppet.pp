class system::sysconfig::puppet (
  $config = undef
) {
  if $config {
    $puppet = $config
  }
  else {
    $puppet = hiera_hash('system::sysconfig::puppet')
  }
  if $puppet {
    syspuppet::header { 'puppet': }
    syspuppet::entry { 'puppet-server':
      file  => 'puppet',
      var   => 'PUPPET_SERVER',
      val   => $puppet['server'],
    }
    syspuppet::entry { 'puppet-port':
      file  => 'puppet',
      var   => 'PUPPET_PORT',
      val   => $puppet['port'],
    }
    syspuppet::entry { 'puppet-log':
      file  => 'puppet',
      var   => 'PUPPET_LOG',
      val   => $puppet['log'],
    }
    syspuppet::entry { 'puppet-extra_opts':
      file  => 'puppet',
      var   => 'PUPPET_EXTRA_OPTS',
      val   => $puppet['extra_opts'],
    }
  }
}
