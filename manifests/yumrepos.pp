class system::yumrepos (
  $config = undef
) {
  if $config {
    $defaults = {
      'enabled'  => '1',
      'gpgcheck' => '1',
    }
    create_resources(yumrepo, $config, $defaults)
  }
}
