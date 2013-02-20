class system::selbooleans (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  if $::selinux == true {
    $defaults = {
      schedule => $schedule,
    }
    if $config {
      include augeasproviders
      create_resources(selboolean, $config, $defaults)
    }
    else {
      $hiera_config = hiera_hash('system::selbooleans', undef)
      if $hiera_config {
        include augeasproviders
        create_resources(selboolean, $hiera_config, $defaults)
      }
    }
  }
}
