class system::files (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources(file, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::files', undef)
    if $hiera_config {
      create_resources(file, $hiera_config, $defaults)
    }
  }
}
