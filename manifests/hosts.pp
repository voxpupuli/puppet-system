class system::hosts (
  $config = undef
) {
  if $config {
    $defaults = {
      ensure => 'present',
    }
    create_resources(host, $config, $defaults)
  }
}
