class system::sysconfig (
  $config  = {},
  $exclude = [],
) {
  if ! member($exclude, 'clock') {
    class { '::system::sysconfig::clock':
      config => $config['clock'],
    }
  }

  if ! member($exclude, 'i18n') {
    class { '::system::sysconfig::i18n':
      config => $config['i18n'],
    }
  }

  if ! member($exclude, 'keyboard') {
    class { '::system::sysconfig::keyboard':
      config => $config['keyboard'],
    }
  }

  if ! member($exclude, 'puppetdashboard') {
    class { '::system::sysconfig::puppetdashboard':
      config => $config['puppetdashboard'],
    }
  }

  if ! member($exclude, 'puppetmaster') {
    class { '::system::sysconfig::puppetmaster':
      config => $config['puppetmaster'],
    }
  }

  if ! member($exclude, 'puppet') {
    class { '::system::sysconfig::puppet':
      config => $config['puppet'],
    }
  }

  if ! member($exclude, 'selinux') {
    class { '::system::sysconfig::selinux':
      config => $config['selinux'],
    }
  }
}
