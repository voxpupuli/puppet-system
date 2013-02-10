class system::mailaliases (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    create_resources(mailalias, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::mailaliases', undef)
    if $hiera_config {
      create_resources(mailalias, $hiera_config, $defaults)
    }
  }
}
