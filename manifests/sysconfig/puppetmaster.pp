class system::sysconfig::puppetmaster (
  $config = undef
) {
  if $config {
    $puppetmaster = $config
  }
  else {
    $puppetmaster = hiera_hash('system::sysconfig::puppetmaster')
  }
  if $puppetmaster {
    system::sysconfig::header { 'puppetmaster': }
    system::sysconfig::entry { 'puppetmaster-manifest':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_MANIFEST',
      val   => $puppetmaster['manifest'],
    }
    system::sysconfig::entry { 'puppetmaster-ports':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_PORTS',
      val   => $puppetmaster['ports'],
    }
    system::sysconfig::entry { 'puppetmaster-log':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_LOG',
      val   => $puppetmaster['log'],
    }
    system::sysconfig::entry { 'puppetmaster-extra_opts':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_EXTRA_OPTS',
      val   => $puppetmaster['extra_opts'],
    }
  }
}
