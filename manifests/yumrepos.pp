class system::yumrepos {
  $yum_repos = hiera_hash('yumrepos', undef)
  if $yum_repos {
    $defaults = {
      'enabled'  => '1',
      'gpgcheck' => '1',
    }
    create_resources(yumrepo, hiera_hash('yumrepos'), $defaults)
  }
}
