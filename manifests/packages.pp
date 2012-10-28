class system::packages {
  $defaults = {
    'ensure' => installed,
  }
  create_resources(package, hiera_hash('packages'), $defaults)
}
