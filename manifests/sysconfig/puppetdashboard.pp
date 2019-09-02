class system::sysconfig::puppetdashboard (
  Hash[String, Hash] $config = {},
) {
  if $config {
    system::sysconfig::header { 'puppet-dashboard':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-dashboard-home':
      file     => 'puppet-dashboard',
      var      => 'DASHBOARD_HOME',
      val      => $config['home'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-dashboard-user':
      file     => 'puppet-dashboard',
      var      => 'DASHBOARD_USER',
      val      => $config['user'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-dashboard-ruby':
      file     => 'puppet-dashboard',
      var      => 'DASHBOARD_RUBY',
      val      => $config['ruby'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-dashboard-environment':
      file     => 'puppet-dashboard',
      var      => 'DASHBOARD_ENVIRONMENT',
      val      => $config['environment'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-dashboard-iface':
      file     => 'puppet-dashboard',
      var      => 'DASHBOARD_IFACE',
      val      => $config['iface'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppet-dashboard-port':
      file     => 'puppet-dashboard',
      var      => 'DASHBOARD_PORT',
      val      => $config['port'],
      schedule => $schedule,
    }
  }
}
