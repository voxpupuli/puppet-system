class system::packages (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'installed',
    schedule => $schedule,
  }
  if $config {
    create_resources(package, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::packages', undef)
    if $hiera_config {
      create_resources(package, $hiera_config, $defaults)
    }
  }
}
