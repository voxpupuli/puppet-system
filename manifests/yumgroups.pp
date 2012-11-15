class system::yumgroups (
  $config = undef
) {
  file { '/root/yum-installed-groups':
    ensure  => 'present',
    source  => 'puppet:///modules/system/yumgroups/yum-installed-groups',
    mode    => '0755',
  }
  if $config {
    $defaults = {
      'ensure' => 'present',
    }
    create_resources('system::yumgroup', $config, $defaults)
  }
}
