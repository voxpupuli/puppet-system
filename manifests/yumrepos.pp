class system::yumrepos {
  $defaults = {
    'enabled'  => '1',
    'gpgcheck' => '1',
  }
  create_resources(yumrepo, hiera_hash('yumrepos'), $defaults)
}
