class system::users::virtual (
  $config = undef
) {
  if $config {
    $defaults = {
      ensure => 'present',
      shell  => '/bin/bash'
    }
    create_resources('@user', $config, $defaults)
  }
}
