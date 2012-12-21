class system::files (
  $config = undef
) {
  if $config {
    $defaults = {
      ensure => 'present',
    }
    create_resources(file, $config, $defaults)
  }
}
