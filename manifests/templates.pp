class system::templates (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  create_resources('system::template', $config, $defaults)
}
