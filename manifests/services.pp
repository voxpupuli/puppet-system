class system::services (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure     => 'running',
    hasrestart => true,
    hasstatus  => true,
    schedule   => $schedule,
  }
  if $config {
    create_resources(service, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::services', undef)
    if $hiera_config {
      create_resources(service, $hiera_config, $defaults)
    }
  }
}
