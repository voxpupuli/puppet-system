class system::users (
  $config = undef
) {
  $defaults = {
    ensure => 'present',
    shell  => '/bin/bash'
  }
  if $config {
    include augeasproviders
    create_resources(user, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::users')
    if $hiera_config {
      include augeasproviders
      create_resources(user, $hiera_config, $defaults)
    }
  }
}
