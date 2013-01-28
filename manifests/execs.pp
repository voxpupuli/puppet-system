class system::execs (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    create_resources(exec, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::execs', undef)
    if $hiera_config {
      create_resources(exec, $hiera_config, $defaults)
    }
  }
}
