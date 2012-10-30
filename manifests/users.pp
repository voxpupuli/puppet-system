class system::users {
  $users = hiera_hash('users', undef)
  if $users {
    $defaults = {
      ensure => 'present',
      shell  => '/bin/bash'
    }
    create_resources(user, $users, $defaults)
  }
}
