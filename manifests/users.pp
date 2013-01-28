class system::users (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
    shell    => '/bin/bash'
  }
  if $config {
    include augeasproviders
    create_resources(user, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::users', undef)
    if $hiera_config {
      include augeasproviders
      create_resources(user, $hiera_config, $defaults)
    }
  }
}
