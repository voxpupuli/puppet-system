class system::sysconfig (
  $sysconfig = undef
) {
  if $sysconfig {
    if $sysconfig['clock'] {
      class { 'system::sysconfig::clock':
        config => $sysconfig['clock']
      }
    }
    if $sysconfig['i18n'] {
      class { 'system::sysconfig::i18n':
        config => $sysconfig['i18n']
      }
    }
    if $sysconfig['keyboard'] {
      class { 'system::sysconfig::keyboard':
        config => $sysconfig['keyboard']
      }
    }
    if $sysconfig['puppet'] {
      class { 'system::sysconfig::puppet':
        config => $sysconfig['puppet']
      }
    }
    if $sysconfig['puppet-dashboard'] {
      class { 'system::sysconfig::puppetdashboard':
        config => $sysconfig['puppet-dashboard']
      }
    }
    if $sysconfig['puppetmaster'] {
      class { 'system::sysconfig::puppetmaster':
        config => $sysconfig['puppetmaster']
      }
    }
    if $sysconfig['selinux'] {
      class { 'system::sysconfig::selinux':
        config => $sysconfig['selinux']
      }
    }
  }
}
