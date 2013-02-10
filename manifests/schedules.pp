class system::schedules (
  $config = undef,
) {
  $defaults = {}
  if $config {
    create_resources(schedule, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::schedules', undef)
    if $hiera_config {
      create_resources(schedule, $hiera_config, $defaults)
    }
  }
  schedule { 'always':
    range => '0 - 23',
  }
}
