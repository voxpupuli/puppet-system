class system::sysconfig::puppetmaster (
  Hash[String, Hash] $config = {},
) {
  if $config {
    system::sysconfig::header { 'puppetmaster':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-manifest':
      file     => 'puppetmaster',
      var      => 'PUPPETMASTER_MANIFEST',
      val      => $config['manifest'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-ports':
      file     => 'puppetmaster',
      var      => 'PUPPETMASTER_PORTS',
      val      => $config['ports'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-log':
      file     => 'puppetmaster',
      var      => 'PUPPETMASTER_LOG',
      val      => $config['log'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'puppetmaster-extra_opts':
      file     => 'puppetmaster',
      var      => 'PUPPETMASTER_EXTRA_OPTS',
      val      => $config['extra_opts'],
      schedule => $schedule,
    }
  }
}
