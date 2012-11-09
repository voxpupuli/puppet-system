class system::sshd (
  $config = undef
) {
  if $config {
    if $config['config'] {
      $config_defaults = {}
      create_resources(sshd_config, $config['config'], $config_defaults)
    }
    if $config['subsystem'] {
      $subsystem_defaults = {}
      create_resources(sshd_config_subsystem, $config['subsystem'], $subsystem_defaults)
    }
  }
}
