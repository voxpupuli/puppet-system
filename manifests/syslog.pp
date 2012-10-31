class system::syslog (
  $syslog = undef
) {
  if $syslog {
    include augeasproviders
    $defaults = { }
    create_resources(syslog, $syslog, $defaults)
  }
}
