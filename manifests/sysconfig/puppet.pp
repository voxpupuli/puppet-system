class system::sysconfig::puppet (
  $config = undef
) {
  if $config {
    $server = $config['server'] ? {
      undef   => 'puppet',
      default => $config['server'],
    }
    $port = $config['port'] ? {
      undef   => '8140',
      default => $config['port'],
    }
    $log = $config['log'] ? {
      undef   => '/var/log/puppet/puppet.log',
      default => $config['log'],
    }
    $extra_opts = $config['extra_opts'] ? {
      undef   => '',
      default => $config['extra_opts'],
    }
    file { '/etc/sysconfig/puppet':
      ensure  => present,
      #content => "# Managed by puppet\nPUPPET_SERVER=\"${server}\"\nPUPPET_PORT=\"${port}\"\nPUPPET_LOG=\"${log}\"\nPUPPET_EXTRA_OPTS=\"${extra_opts}\"\n",
      content => template('system/sysconfig/puppet.erb'),
    }
  }
}
