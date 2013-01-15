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
    system::sysconfig::header { 'puppet': }
    system::sysconfig::entry { 'puppet-server':
      file  => 'puppet',
      var   => 'PUPPET_SERVER',
      val   => $puppet['server'],
    }
    system::sysconfig::entry { 'puppet-port':
      file  => 'puppet',
      var   => 'PUPPET_PORT',
      val   => $puppet['port'],
    }
    system::sysconfig::entry { 'puppet-log':
      file  => 'puppet',
      var   => 'PUPPET_LOG',
      val   => $puppet['log'],
    }
    system::sysconfig::entry { 'puppet-extra_opts':
      file  => 'puppet',
      var   => 'PUPPET_EXTRA_OPTS',
      val   => $puppet['extra_opts'],
    }
  }
}
