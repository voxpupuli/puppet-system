class system::sysconfig (
  $config   = {},
  $schedule = $::system::schedule,
) {
  class { '::system::sysconfig::clock':
    config   => $config['clock'],
    schedule => $schedule,
  }

  class { '::system::sysconfig::i18n':
    config   => $config['i18n'],
    schedule => $schedule,
  }

  class { '::system::sysconfig::keyboard':
    config   => $config['keyboard'],
    schedule => $schedule,
  }

  class { '::system::sysconfig::puppetdashboard':
    config   => $config['puppetdashboard'],
    schedule => $schedule,
  }

  class { '::system::sysconfig::puppetmaster':
    config   => $config['puppetmaster'],
    schedule => $schedule,
  }

  class { '::system::sysconfig::puppet':
    config   => $config['puppet'],
    schedule => $schedule,
  }

  class { '::system::sysconfig::selinux':
    config   => $config['selinux'],
    schedule => $schedule,
  }
}
