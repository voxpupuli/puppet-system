class system::hosts (
  $config = undef
) {
  $defaults = {
    ensure => 'present',
  }
  if $config {
    create_resources(host, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::hosts')
    if $hiera_config {
      create_resources(host, $hiera_config, $defaults)
    }
  }
}
