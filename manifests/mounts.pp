class system::mounts (
  $mounts = undef
) {
  if $mounts {
    $defaults = {
      'atboot' => true,
      'ensure' => 'mounted',
    }
    create_resources(package, $mounts, $defaults)
  }
}
