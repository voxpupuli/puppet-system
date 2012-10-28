class system::users {
  $defaults = {
    ensure => 'present',
    shell  => '/bin/bash'
  }
  create_resources(user, hiera_hash('users'), $defaults)
}
