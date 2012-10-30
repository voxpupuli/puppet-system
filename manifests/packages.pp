class system::packages {
  $packages = hiera_hash('packages', undef)
  if $packages {
    $defaults = {
      'ensure' => installed,
    }
    create_resources(package, $packages, $defaults)
  }
}
