class system::groups (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
  Boolean $real              = false,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $sys_schedule,
  }
  if $real {
    $type = 'group'
  }
  else {
    $type = '@group'
  }
    system_create_resources($type, $config, $defaults)
}
