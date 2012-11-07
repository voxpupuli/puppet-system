class system::sysconfig::puppetmaster (
  $config = undef
) {
  if $config {
    $manifest = $config['manifest'] ? {
      undef   => '/etc/puppet/manifests/site.pp',
      default => $config['manifest'],
    }
    $log = $config['log'] ? {
      undef   => 'syslog',
      default => $config['log'],
    }
    $ports = $config['ports'] ? {
      undef   => '8140',
      default => $config['ports'],
    }
    $extra_opts = $config['extra_opts'] ? {
      undef   => '',
      default => $config['extra_opts'],
    }
    file { '/etc/sysconfig/puppetmaster':
      ensure  => present,
      #content => "# Managed by puppet\nPUPPETMASTER_MANIFEST=\"${manifest}\"\nPUPPETMASTER_PORTS=\"${ports}\"\nPUPPETMASTER_LOG=\"${log}\"\nPUPPETMASTER_EXTRA_OPTS=\"${extra_opts}\"\n",
      content => template('system/sysconfig/puppetmaster.erb'),
    }
  }
}
