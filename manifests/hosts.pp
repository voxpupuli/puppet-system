class system::hosts (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources(host, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::hosts', undef)
    if $hiera_config {
      create_resources(host, $hiera_config, $defaults)
    }
  }
}
