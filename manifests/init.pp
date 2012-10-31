class system (
  $config    = {},
  $use_hiera = true
){
  # Ensure providers are set before resources are created
  stage { 'first':  before => Stage['second'] }
  # Ensure packages, users and groups are created
  # before other resources that may depend on them
  stage { 'second': before => Stage['main'] }
  class {
    'system::providers': stage => first;
    'system::packages':  stage => second;
    'system::groups':    stage => second;
    'system::users':     stage => second;
  }
  if $use_hiera {
    $system = hiera_hash('system', $config)
  }
  else {
    $system = $config
  }
  if $system {
    if $system['providers'] {
      class { 'system::providers': providers => $system['providers'] }
    }
    if $system['yumrepos'] {
      class { 'system::yumrepos':  yumrepos  => $system['yumrepos'] }
    }
    if $system['mounts'] {
      class { 'system::mounts':    mounts    => $system['mounts'] }
    }
    if $system['packages'] {
      class { 'system::packages':  packages  => $system['packages'] }
    }
    if $system['groups'] {
      class { 'system::groups':    groups    => $system['groups'] }
    }
    if $system['users'] {
      class { 'system::users':     users     => $system['users'] }
    }
    if $system['sshd'] {
      class { 'system::sshd':      sshd      => $system['sshd'] }
    }
    if $system['sysctl'] {
      class { 'system::sysctl':    systcl    => $system['sysctl'] }
    }
    if $system['syslog'] {
      class { 'system::syslog':    syslog    => $system['syslog'] }
    }
    if $system['limits'] {
      class { 'system::limits':    limits    => $system['limits'] }
    }
  }
}
