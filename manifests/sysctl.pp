class system::sysctl (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    include augeasproviders
    create_resources(sysctl, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::sysctl', undef)
    if $hiera_config {
      include augeasproviders
      create_resources(sysctl, $hiera_config, $defaults)
    }
  }
}
