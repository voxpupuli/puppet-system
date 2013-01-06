class system::execs (
  $config = undef
) {
  if $config {
    $defaults = {
    }
    create_resources(exec, $config, $defaults)
  }
}
