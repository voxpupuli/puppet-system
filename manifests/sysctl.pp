class system::sysctl (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  include augeasproviders
  create_resources(sysctl, $config, $defaults)
}
