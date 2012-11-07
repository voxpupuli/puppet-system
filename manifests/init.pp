class system (
  $config    = {},
  $use_hiera = true
){
  # Ensure packages, users and groups are created
  # before other resources that may depend on them
  if ! defined(Stage['second']) {
    stage { 'second': before => Stage['main'] }
  }
  # Ensure providers are set before resources are created
  if ! defined(Stage['first']) {
    stage { 'first':  before => Stage['second'] }
  }

  if $use_hiera {
    $system = hiera_hash('system', $config)
  }
  else {
    $system = $config
  }
  if $system {
    if $system['groups'] {
      class { '::system::groups':
        groups    => $system['groups'],
        stage     => second,
      }
    }
    if $system['hosts'] {
      class { '::system::hosts':
        hosts     => $system['hosts']
      }
    }
    if $system['limits'] {
      class { '::system::limits':
        limits    => $system['limits'],
      }
    }
    if $system['mailaliases'] {
      class { '::system::mailaliases':
        mailaliases => $system['mailaliases']
      }
    }
    if $system['mounts'] {
      class { '::system::mounts':
        mounts    => $system['mounts'],
      }
    }
    if $system['packages'] {
      class { '::system::packages':
        packages  => $system['packages'],
        stage     => second,
      }
    }
    if $system['services'] {
      class { '::system::services':
        services  => $system['services'],
      }
    }
    if $system['sshd'] {
      class { '::system::sshd':
        sshd      => $system['sshd'],
      }
    }
    if $system['sysconfig'] {
      class { '::system::sysconfig':
        sysconfig => $system['sysconfig'],
      }
    }
    if $system['sysctl'] {
      class { '::system::sysctl':
        sysctl    => $system['sysctl'],
      }
    }
    #if $system['syslog'] {
    #  class { '::system::syslog':
    #    syslog    => $system['syslog'],
    #  }
    #}
    if $system['users'] {
      class { '::system::users':
        users     => $system['users'],
        stage     => second,
      }
    }
    if $system['yumrepos'] {
      class { '::system::yumrepos':
        yumrepos  => $system['yumrepos']
      }
    }
    if $system['providers'] {
      class { '::system::providers':
        providers => $system['providers'],
        stage     => first
      }
    }
  }
}
