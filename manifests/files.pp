class system::files (
  $config = undef
) {
  $defaults = {
    ensure => 'present',
  }
  if $config {
    create_resources(file, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::files', undef)
    if $hiera_config {
      create_resources(file, $hiera_config, $defaults)
    }
  }
}
