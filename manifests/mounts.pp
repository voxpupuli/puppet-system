class system::mounts (
  $config = undef
) {
  $defaults = {
    'atboot' => true,
    'ensure' => 'mounted',
  }
  if $config {
    create_resources(mount, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::mounts', undef)
    if $hiera_config {
      create_resources(mount, $hiera_config, $defaults)
    }
  }
}
