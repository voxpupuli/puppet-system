class system::yumgroups (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
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
