class system (
  $config  = {},
  $exclude = []
){
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

  if ! member(exclude, 'augeas') {
    class { '::system::augeas':
      config => $config['augeas'],
    }
  }

  if ! member(exclude, 'crontabs') {
    class { '::system::crontabs':
      config => $config['crontabs'],
    }
  }

  if ! member(exclude, 'execs') {
    class { '::system::execs':
      config => $config['execs'],
      stage  => last,
    }
  }

  if ! member(exclude, 'facts') {
    class { '::system::facts':
      config => $config['facts'],
    }
  }

  if ! member(exclude, 'files') {
    class { '::system::files':
      config => $config['files'],
      stage  => third,
    }
  }

  if ! member(exclude, 'groups') {
    class { '::system::groups':
      config => $config['groups'],
      stage  => second
    }
  }

  if ! member(exclude, 'hosts') {
    class { '::system::hosts':
      config => $config['hosts'],
    }
  }

  if ! member(exclude, 'limits') {
    class { '::system::limits':
      config => $config['limits'],
    }
  }

  if ! member(exclude, 'mailaliases') {
    class { '::system::mailaliases':
      config => $config['mailaliases'],
    }
  }

  if ! member(exclude, 'mounts') {
    class { '::system::mounts':
      config => $config['mounts'],
      stage  => last,
    }
  }

  if ! member(exclude, 'packages') {
    class { '::system::packages':
      config  => $config['packages'],
      stage   => second,
      require => Class['::system::yumgroups'],
    }
  }

  if ! member(exclude, 'schedules') {
    class { '::system::schedules':
      config => $config['schedules'],
    }
  }

  if ! member(exclude, 'services') {
    class { '::system::services':
      config => $config['services'],
    }
  }

  if ! member(exclude, 'sshd') {
    class { '::system::sshd':
      config => $config['sshd'],
    }
  }

  if ! member(exclude, 'sysconfig') {
    class { '::system::sysconfig':
      config => $config['sysconfig'],
    }
  }

  if ! member(exclude, 'sysctl') {
    class { '::system::sysctl':
      config => $config['sysctl'],
    }
  }

  if ! member(exclude, 'users') {
    class { '::system::users':
      config  => $config['users'],
      stage   => second,
      require => Class['::system::groups'],
    }
  }

  if ! member(exclude, 'yumgroups') {
    class { '::system::yumgroups':
      config => $config['yumgroups'],
      stage  => second,
    }
  }

  if ! member(exclude, 'yumrepos') {
    class { '::system::yumrepos':
      config => $config['yumrepos'],
      stage  => first,
    }
  }

  if ! member(exclude, 'providers') {
    class { '::system::providers':
      config => $config['providers'],
      stage  => first
    }
  }
}
