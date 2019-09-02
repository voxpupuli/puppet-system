class system::services (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    ensure     => 'running',
    hasrestart => true,
    hasstatus  => true,
    schedule   => $sys_schedule,
  }
  create_resources(service, $config, $defaults)
}
