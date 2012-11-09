class system::services (
  $config = undef
) {
  if $config {
    $defaults = {
      ensure     => 'running',
      hasrestart => true,
      hasstatus  => true,
    }
    create_resources(service, $config, $defaults)
  }
}
