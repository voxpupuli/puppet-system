class system::services (
  $services = undef
) {
  if $services {
    $defaults = {
      ensure     => 'running',
      hasrestart => 'true',
      hasstatus  => 'true',
    }
    create_resources(service, $services, $defaults)
  }
}
