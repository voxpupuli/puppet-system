class system::packages (
  $packages = undef
) {
  if $packages {
    $defaults = {
      'ensure' => installed,
    }
    create_resources(package, $packages, $defaults)
  }
}
