class system::sysconfig::puppet (
  Hash[String, Hash] $config = {},
) {
  if $config {
    system::sysconfig::header { 'puppet':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-server':
      file     => 'puppet',
      var      => 'PUPPET_SERVER',
      val      => $config['server'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-port':
      file     => 'puppet',
      var      => 'PUPPET_PORT',
      val      => $config['port'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-log':
      file     => 'puppet',
      var      => 'PUPPET_LOG',
      val      => $config['log'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-extra_opts':
      file     => 'puppet',
      var      => 'PUPPET_EXTRA_OPTS',
      val      => $config['extra_opts'],
      schedule => $schedule,
    }
  }
}
