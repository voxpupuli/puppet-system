class system::sshd (
  $config = undef
) {
  if $config {
    include augeasproviders
    $defaults = {}
    create_resources(sshd_config, $config, $defaults)
  }
}
