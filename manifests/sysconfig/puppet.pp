class system::sysconfig::puppet (
  $config = undef
) {
  if $config {
    sysconfig::header { 'puppet': }
    sysconfig::entry { 'puppet-server':
      file  => 'puppet',
      var   => 'PUPPET_SERVER',
      val   => $config['server'],
    }
    sysconfig::entry { 'puppet-port':
      file  => 'puppet',
      var   => 'PUPPET_PORT',
      val   => $config['port'],
    }
    sysconfig::entry { 'puppet-log':
      file  => 'puppet',
      var   => 'PUPPET_LOG',
      val   => $config['log'],
    }
    sysconfig::entry { 'puppet-extra_opts':
      file  => 'puppet',
      var   => 'PUPPET_EXTRA_OPTS',
      val   => $config['extra_opts'],
    }
  }
}
