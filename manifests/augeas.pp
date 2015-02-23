class system::augeas (
  $config   = {},
  $schedule = $::system::schedule,
) {
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    create_resources(augeas, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::augeas', {})
    if $hiera_config {
      create_resources(augeas, $hiera_config, $defaults)
    }
  }
}
