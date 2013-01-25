class system::augeas (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    create_resources(augeas, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::augeas', undef)
    if $hiera_config {
      create_resources(augeas, $hiera_config, $defaults)
    }
  }
}
