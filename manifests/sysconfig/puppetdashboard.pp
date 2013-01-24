class system::sysconfig::puppetdashboard (
  $config = undef
) {
  if $config {
    $puppetdashboard = $config
  }
  else {
    $puppetdashboard = hiera_hash('system::sysconfig::puppetdashboard', undef)
  }
  if $puppetdashboard {
    system::sysconfig::header { 'puppet-dashboard': }
    system::sysconfig::entry { 'puppet-dashboard-home':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_HOME',
      val   => $puppetdashboard['home'],
    }
    system::sysconfig::entry { 'puppet-dashboard-user':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_USER',
      val   => $puppetdashboard['user'],
    }
    system::sysconfig::entry { 'puppet-dashboard-ruby':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_RUBY',
      val   => $puppetdashboard['ruby'],
    }
    system::sysconfig::entry { 'puppet-dashboard-environment':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_ENVIRONMENT',
      val   => $puppetdashboard['environment'],
    }
    system::sysconfig::entry { 'puppet-dashboard-iface':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_IFACE',
      val   => $puppetdashboard['iface'],
    }
    system::sysconfig::entry { 'puppet-dashboard-port':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_PORT',
      val   => $puppetdashboard['port'],
    }
  }
}
