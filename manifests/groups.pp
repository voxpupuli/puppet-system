class system::groups (
  $config = undef
) {
  $defaults = {
    ensure => 'present',
  }
  if $config {
    create_resources(group, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::groups')
    if $hiera_config {
      create_resources(group, $hiera_config, $defaults)
    }
  }
}
