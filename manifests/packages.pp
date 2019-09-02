class system::packages (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    ensure   => 'installed',
    schedule => $sys_schedule,
  }
  create_resources(package, $config, $defaults)
}
