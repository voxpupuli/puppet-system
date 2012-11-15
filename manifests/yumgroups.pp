class system::yumgroups (
  $config = undef
) {
  file { '/root/yum-installed-groups':
    ensure  => 'present',
    source  => 'puppet:///modules/system/yumgroups/yum-installed-groups',
    mode    => '0755',
  }
  exec { 'clear-yum-installed-groups-cache':
    command     => '/bin/rm -f /root/.yum-group-installed.cache',
    refreshonly => true,
  }
  if $config {
    $defaults = {
      'ensure' => 'present',
    }
    create_resources('system::yumgroup', $config, $defaults)
  }
}
