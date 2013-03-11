class system (
  $config   = {},
  $schedule = undef,
) {
  # Ensure that files and directories are created before
  # other resources (like mounts) that may depend on them
  if ! defined(Stage['third']) {
    stage { 'third': before => Stage['main'] }
  }
  # Ensure packages, users and groups are created
  # before other resources that may depend on them
  if ! defined(Stage['second']) {
    stage { 'second': before => Stage['third'] }
  }
  # Ensure providers are set before resources are created
  if ! defined(Stage['first']) {
    stage { 'first':  before => Stage['second'] }
  }
  # Things to do last because the depend on lots of other resources
  if ! defined(Stage['last']) {
    stage { 'last': require => Stage['main'] }
  }

  class { '::system::augeas':
    config => $config['augeas'],
  }

  class { '::system::crontabs':
    config => $config['crontabs'],
  }

  class { '::system::execs':
    config => $config['execs'],
    stage  => last,
  }

  class { '::system::facts':
    config => $config['facts'],
  }

  class { '::system::files':
    config => $config['files'],
    stage  => third,
  }

  class { '::system::groups':
    config => $config['groups'],
    stage  => second
  }

  class { '::system::groups::realize':
    groups  => $config['realize_groups'],
    stage   => second,
    require => Class['::system::groups'],
  }

  class { '::system::hosts':
    config => $config['hosts'],
  }

  class { '::system::limits':
    config => $config['limits'],
  }

  class { '::system::mail':
    config => $config['mail'],
  }

  class { '::system::mounts':
    config => $config['mounts'],
    stage  => last,
  }

  include '::system::network'

  class { '::system::ntp':
    config => $config['ntp'],
  }

  class { '::system::packages':
    config  => $config['packages'],
    stage   => second,
    require => Class['::system::yumgroups'],
  }

  class { '::system::schedules':
    config => $config['schedules'],
    stage  => first,
  }

  class { '::system::selbooleans':
    config => $config['selbooleana'],
    stage  => first,
  }

  class { '::system::services':
    config => $config['services'],
  }

  class { '::system::sshd':
    config => $config['sshd'],
  }

  class { '::system::sysconfig':
    config => $config['sysconfig'],
  }

  class { '::system::sysctl':
    config => $config['sysctl'],
  }

  class { '::system::templates':
    config => $config['templates'],
    stage  => last,
  }

  class { '::system::users':
    config  => $config['users'],
    stage   => second,
    require => Class['::system::groups'],
  }

  class { '::system::users::realize':
    users   => $config['realize_users'],
    stage   => second,
    require => Class['::system::users', '::system::groups::realize'],
  }

  class { '::system::yumgroups':
    config => $config['yumgroups'],
    stage  => second,
  }

  class { '::system::yumrepos':
    config  => $config['yumrepos'],
    stage   => first,
    require => Class['::system::schedules'],
  }

  class { '::system::providers':
    config => $config['providers'],
    stage  => first
  }
}
