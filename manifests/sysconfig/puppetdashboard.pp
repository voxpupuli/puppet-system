class system::sysconfig::puppetdashboard (
  $config = undef
) {
  if $config {
    $puppetdashboard = $config
  }
  else {
    $puppetdashboard = hiera_hash('system::sysconfig::puppetdashboard')
  }
  if $puppetdashboard {
    syspuppetdashboard::header { 'puppet-dashboard': }
    syspuppetdashboard::entry { 'puppet-dashboard-home':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_HOME',
      val   => $puppetdashboard['home'],
    }
    syspuppetdashboard::entry { 'puppet-dashboard-user':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_USER',
      val   => $puppetdashboard['user'],
    }
    syspuppetdashboard::entry { 'puppet-dashboard-ruby':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_RUBY',
      val   => $puppetdashboard['ruby'],
    }
    syspuppetdashboard::entry { 'puppet-dashboard-environment':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_ENVIRONMENT',
      val   => $puppetdashboard['environment'],
    }
    syspuppetdashboard::entry { 'puppet-dashboard-iface':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_IFACE',
      val   => $puppetdashboard['iface'],
    }
    syspuppetdashboard::entry { 'puppet-dashboard-port':
      file  => 'puppet-dashboard',
      var   => 'DASHBOARD_PORT',
      val   => $puppetdashboard['port'],
    }
  }
}
