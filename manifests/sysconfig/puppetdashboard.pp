class system::sysconfig::puppetdashboard (
  $config = undef
) {
  if $config {
    $home = $config['home'] ? {
      undef   => '/usr/share/puppet-dashboard',
      default => $config['home'],
    }
    $user  = $config['user'] ? {
      undef   => 'puppet-dashboard',
      default => $config['user'],
    }
    $ruby  = $config['ruby'] ? {
      undef   => '/usr/bin/ruby',
      default => $config['ruby'],
    }
    $environment  = $config['environment'] ? {
      undef   => 'production',
      default => $config['environment'],
    }
    $ip = $config['ip'] ? {
      undef   => '0.0.0.0',
      default => $config['ip'],
    }
    $port = $config['port'] ? {
      undef   => '3000',
      default => $config['port'],
    }
    file { '/etc/sysconfig/puppet-dashboard':
      ensure  => present,
      #content => "# Managed by puppet\nDASHBOARD_HOME=\"${home}\"\nDASHBOARD_USER=\"${user}\"\nDASHBOARD_RUBY=\"${ruby}\"\nDASHBOARD_ENVIRONMENT=\"${environment}\"\nDASHBOARD_IFACE=\"${ip}\"\nDASHBOARD_PORT=\"${port}\"\n",
      content => template('system/sysconfig/puppetdashboard.erb'),
    }
  }
}
