class system::yumrepos (
  Hash[String, Hash] $config = {},
  String $sys_schedule       = 'always',
) {
  $defaults = {
    enabled  => '1',
    gpgcheck => '1',
    schedule => $sys_schedule,
  }
  create_resources(yumrepo, $config, $defaults)
}
