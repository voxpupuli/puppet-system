class system::mounts (
  $config = undef
) {
  if $config {
    $defaults = {
      'atboot' => true,
      'ensure' => 'mounted',
    }
    create_resources(package, $config, $defaults)
  }
}
