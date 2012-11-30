class system::yumgroups (
  $config = undef
) {
  if $config {
    $defaults = {
      'ensure' => 'present',
    }
    create_resources('system::yumgroup', $config, $defaults)
  }
}
