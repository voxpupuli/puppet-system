class system::sysctl (
  $config = undef
) {
  if $config {
    include augeasproviders
    $defaults = { }
    create_resources(sysctl, $config, $defaults)
  }
}
