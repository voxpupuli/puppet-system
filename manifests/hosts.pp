class system::hosts (
  $config   = undef,
  $sys_schedule = 'always',
) {
  $defaults = {
    ensure   => 'present',
    schedule => $sys_schedule,
  }
  if $config {
    create_resources(host, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::hosts', undef)
    if $hiera_config {
      create_resources(host, $hiera_config, $defaults)
    }
  }
}
