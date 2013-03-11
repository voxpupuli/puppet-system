class system::selbooleans (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  if $::selinux == true {
    $defaults = {
      schedule => $schedule,
    }
    if $config {
      create_resources(selboolean, $config, $defaults)
    }
    else {
      $hiera_config = hiera_hash('system::selbooleans', undef)
      if $hiera_config {
        create_resources(selboolean, $hiera_config, $defaults)
      }
    }
  }
}
