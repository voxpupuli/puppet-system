class system::mounts (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    atboot   => true,
    ensure   => 'mounted',
    schedule => $sys_schedule,
  }
  create_resources(mount, $config, $defaults)
}
