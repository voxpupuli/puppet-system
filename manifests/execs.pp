class system::execs (
  $config = undef
) {
  $defaults = {}
  if $config {
    create_resources(exec, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::execs', undef)
    if $hiera_config {
      create_resources(exec, $hiera_config, $defaults)
    }
  }
}
