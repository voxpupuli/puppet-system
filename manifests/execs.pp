class system::execs (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  create_resources(exec, $config, $defaults)
}
