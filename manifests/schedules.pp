class system::schedules (
  $config = undef
) {
  $defaults = {}
  if $config {
    create_resources(schedule, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::schedules')
    if $hiera_config {
      create_resources(schedule, $hiera_config, $defaults)
    }
  }
}
