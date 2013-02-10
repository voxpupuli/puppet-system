class system::sysconfig::puppetmaster (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $puppetmaster = $config
  }
  else {
    $puppetmaster = hiera_hash('system::sysconfig::puppetmaster', undef)
  }
  if $puppetmaster {
    system::sysconfig::header { 'puppetmaster':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-manifest':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_MANIFEST',
      val   => $puppetmaster['manifest'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-ports':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_PORTS',
      val   => $puppetmaster['ports'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-log':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_LOG',
      val   => $puppetmaster['log'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-extra_opts':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_EXTRA_OPTS',
      val   => $puppetmaster['extra_opts'],
      schedule => $schedule,
    }
  }
}
