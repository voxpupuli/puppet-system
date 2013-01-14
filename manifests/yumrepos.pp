class system::yumrepos (
  $config = undef
) {
  $defaults = {
    'enabled'  => '1',
    'gpgcheck' => '1',
  }
  if $config {
    create_resources(yumrepo, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::yumrepos')
    if $hiera_config {
      create_resources(yumrepo, $hiera_config, $defaults)
    }
  }
}
