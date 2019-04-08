class system::sshd::subsystem (
  $config = undef
) {
  if $config {
    include augeasproviders
    $defaults = {}
    create_resources(sshd_config_subsystem, $config, $defaults)
  }
}
