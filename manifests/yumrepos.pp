class system::yumrepos (
  $yumrepos = undef
) {
  if $yumrepos {
    $defaults = {
      'enabled'  => '1',
      'gpgcheck' => '1',
    }
    create_resources(yumrepo, $yumrepos, $defaults)
  }
}
