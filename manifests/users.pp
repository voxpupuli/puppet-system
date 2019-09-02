class system::users (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
  Boolean $real              = false,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $sys_schedule,
    shell    => '/bin/bash',
  }
  if $real {
    $type = 'user'
  }
  else {
    $type = '@user'
  }
  system_create_resources($type, $config, $defaults)
}
