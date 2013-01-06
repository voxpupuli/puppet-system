class system (
  $config = {},
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

  $crontabs = hiera_hash('system::cron', $config['crontabs'])
  class { '::system::crontabs':
    config => $crontabs,
  }

  $execs = hiera_hash('system::exec', $config['execs'])
  class { '::system::execs':
    config => $execs,
    stage  => last,
  }

  $facts = hiera_hash('system::facts', $config['facts'])
  class { '::system::facts':
    config => $facts,
  }

  $files = hiera_hash('system::files', $config['files'])
  class { '::system::files':
    config => $files,
    stage  => third,
  }

  $groups = hiera_hash('system::groups', $config['groups'])
  class { '::system::groups':
    config => $groups,
    stage  => second,
  }

  $hosts = hiera_hash('system::hosts', $config['hosts'])
  class { '::system::hosts':
    config => $hosts,
  }

  $limits = hiera_hash('system::limits', $config['limits'])
  class { '::system::limits':
    config => $limits,
  }

  $mailaliases = hiera_hash('system::mailaliases', $config['mailaliases'])
  class { '::system::mailaliases':
    config => $mailaliases,
  }

  $mounts = hiera_hash('system::mounts', $config['mounts'])
  class { '::system::mounts':
    config => $mounts,
    stage  => last,
  }

  $packages = hiera_hash('system::packages', $config['packages'])
  class { '::system::packages':
    config  => $packages,
    stage   => second,
    require => Class['::system::yumgroups'],
  }

  $services = hiera_hash('system::services', $config['services'])
  class { '::system::services':
    config => $services,
  }

  $sshd = hiera_hash('system::sshd', $config['sshd'])
  class { '::system::sshd':
    config => $sshd,
  }

  if $config['sysconfig'] {
    $sysconfig = $config['sysconfig']
  }
  else {
    $sysconfig = {}
  }
  $clock = hiera_hash('system::sysconfig::clock', $sysconfig['clock'])
  class { '::system::sysconfig::clock':
    config => $clock,
  }
  $i18n = hiera_hash('system::sysconfig::i18n', $sysconfig['i18n'])
  class { '::system::sysconfig::i18n':
    config => $i18n,
  }
  $keyboard = hiera_hash('system::sysconfig::keyboard', $sysconfig['keyboard'])
  class { '::system::sysconfig::keyboard':
    config => $keyboard,
  }
  $puppetdashboard = hiera_hash('system::sysconfig::puppetdashboard', $sysconfig['puppetdashboard'])
  class { '::system::sysconfig::puppetdashboard':
    config => $puppetdashboard,
  }
  $puppetmaster = hiera_hash('system::sysconfig::puppetmaster', $sysconfig['puppetmaster'])
  class { '::system::sysconfig::puppetmaster':
    config => $puppetmaster,
  }
  $puppet = hiera_hash('system::sysconfig::puppet', $sysconfig['puppet'])
  class { '::system::sysconfig::puppet':
    config => $puppet,
  }
  $selinux = hiera_hash('system::sysconfig::selinux', $sysconfig['selinux'])
  class { '::system::sysconfig::selinux':
    config => $selinux,
  }

  $sysctl = hiera_hash('system::sysctl', $config['sysctl'])
  class { '::system::sysctl':
    config => $sysctl,
  }

  #$syslog = hiera_hash('system::syslog', $config['syslog'])
  #class { '::system::syslog':
  #  config => $syslog,
  #}

  $users = hiera_hash('system::users', $config['users'])
  class { '::system::users':
    config  => $users,
    stage   => second,
    require => Class['::system::groups'],
  }

  $yumgroups = hiera_hash('system::yumgroups', $config['yumgroups'])
  class { '::system::yumgroups':
    config => $yumgroups,
    stage  => second,
  }

  $yumrepos = hiera_hash('system::yumrepos', $config['yumrepos'])
  class { '::system::yumrepos':
    config => $yumrepos,
    stage  => first,
  }

  $providers = hiera_hash('system::providers', $config['providers'])
  class { '::system::providers':
    config => $providers,
    stage  => first
  }
}
