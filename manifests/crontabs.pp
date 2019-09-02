class system::crontabs (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    ensure   => 'present',
    schedule => $sys_schedule,
    user     => 'root',
  }
  create_resources(cron, $config, $defaults)
}
