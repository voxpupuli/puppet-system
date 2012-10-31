class system::sshd (
  $sshd = undef
) {
  if $sshd {
    if $sshd['config'] {
      $config_defaults = {}
      create_resources(sshd_config, $sshd['config'], $config_defaults)
    }
    if $sshd['subsystem'] {
      $subsystem_defaults = {}
      create_resources(sshd_config_subsystem, $sshd['subsystem'], $subsystem_defaults)
    }
  }
}
