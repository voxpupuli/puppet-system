class system::groups (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources(group, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::groups', undef)
    if $hiera_config {
      create_resources(group, $hiera_config, $defaults)
    }
  }
}
