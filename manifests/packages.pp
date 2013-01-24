class system::packages (
  $config = undef
) {
  $defaults = {
    'ensure' => installed,
  }
  if $config {
    create_resources(package, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::packages', undef)
    if $hiera_config {
      create_resources(package, $hiera_config, $defaults)
    }
  }
}
