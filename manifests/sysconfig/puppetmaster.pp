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
    syspuppetmaster::header { 'puppetmaster': }
    syspuppetmaster::entry { 'puppetmaster-manifest':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_MANIFEST',
      val   => $puppetmaster['manifest'],
    }
    syspuppetmaster::entry { 'puppetmaster-ports':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_PORTS',
      val   => $puppetmaster['ports'],
    }
    syspuppetmaster::entry { 'puppetmaster-log':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_LOG',
      val   => $puppetmaster['log'],
    }
    syspuppetmaster::entry { 'puppetmaster-extra_opts':
      file  => 'puppetmaster',
      var   => 'PUPPETMASTER_EXTRA_OPTS',
      val   => $puppetmaster['extra_opts'],
    }
  }
}
