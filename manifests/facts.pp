class system::facts (
  $config = undef
) {
  $defaults = {}
  if $config {
    create_resources('system::fact', $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::facts', undef)
    if $hiera_config {
      create_resources('system::fact', $hiera_config, $defaults)
    }
  }
}
