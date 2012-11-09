class system::packages (
  $config = undef
) {
  if $config {
    $defaults = {
      'ensure' => installed,
    }
    create_resources(package, $config, $defaults)
  }
}
