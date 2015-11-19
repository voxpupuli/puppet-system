class system::yumrepos (
  $config   = undef,
  $sys_schedule = 'always',
) {
  $defaults = {
    enabled  => '1',
    gpgcheck => '1',
    schedule => $sys_schedule,
  }
  if $config {
    create_resources(yumrepo, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::yumrepos', undef)
    if $hiera_config {
      create_resources(yumrepo, $hiera_config, $defaults)
    }
  }
}
