class system::sysconfig::puppetdashboard (
  $config = undef
) {
  if $config {
    sysconfig::header { 'puppet-dashboard': }
    sysconfig::entry { 'puppet-dashboard-home':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_HOME',
      val   => $config['home'],
    }
    sysconfig::entry { 'puppet-dashboard-user':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_USER',
      val   => $config['user'],
    }
    sysconfig::entry { 'puppet-dashboard-ruby':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_RUBY',
      val   => $config['ruby'],
    }
    sysconfig::entry { 'puppet-dashboard-environment':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_ENVIRONMENT',
      val   => $config['environment'],
    }
    sysconfig::entry { 'puppet-dashboard-iface':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_IFACE',
      val   => $config['iface'],
    }
    sysconfig::entry { 'puppet-dashboard-port':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_PORT',
      val   => $config['port'],
    }
  }
}
