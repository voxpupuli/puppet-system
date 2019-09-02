class system::files (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    ensure   => 'present',
    schedule => $sys_schedule,
  }
  create_resources(file, $config, $defaults)
}
