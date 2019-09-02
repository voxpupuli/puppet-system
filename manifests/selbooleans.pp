class system::selbooleans (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  if $::selinux == true {
    $defaults = {
      schedule => $sys_schedule,
    }
    create_resources(selboolean, $config, $defaults)
  }
}
