class system::sysconfig::puppetmaster (
  $config = undef
) {
  if $config {
    sysconfig::header { 'puppetmaster': }
    sysconfig::entry { 'puppetmaster-manifest':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_MANIFEST',
      val   => $config['manifest'],
    }
    sysconfig::entry { 'puppetmaster-ports':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_PORTS',
      val   => $config['ports'],
    }
    sysconfig::entry { 'puppetmaster-log':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_LOG',
      val   => $config['log'],
    }
    sysconfig::entry { 'puppetmaster-extra_opts':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_EXTRA_OPTS',
      val   => $config['extra_opts'],
    }
  }
}
