class system::sshd::subsystem (
  Hash[String, Hash] $config = {},
) {
  include augeasproviders
  $defaults = {}
  create_resources(sshd_config_subsystem, $config, $defaults)
}
