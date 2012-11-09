class system::syslog (
  $config = undef
) {
  if $config {
    include augeasproviders
    $defaults = { }
    create_resources(syslog, $config, $defaults)
  }
}
