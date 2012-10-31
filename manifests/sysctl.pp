class system::sysctl (
  $sysctl = undef
) {
  if $sysctl {
    include augeasproviders
    $defaults = { }
    create_resources(sysctl, $sysctl, $defaults)
  }
}
