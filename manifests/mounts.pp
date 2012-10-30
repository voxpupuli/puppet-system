class system::mounts {
  $mounts = hiera_hash('mounts', undef)
  if $mounts {
    $defaults = {
      'atboot' => true,
      'ensure' => 'mounted',
    }
    create_resources(package, $mounts, $defaults)
  }
}
