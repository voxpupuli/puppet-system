class system::yumgroups (
  $config   = undef,
  $sys_schedule = 'always',
) {
  $defaults = {
    ensure   => 'present',
    schedule => $sys_schedule,
  }
  if $config {
    create_resources('system::yumgroup', $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::yumgroups', undef)
    if $hiera_config {
      create_resources('system::yumgroup', $hiera_config, $defaults)
    }
  }
}
