class system::templates (
  $config   = undef,
  $sys_schedule = 'always',
) {
  $defaults = {
    schedule => $sys_schedule,
  }
  if $config {
    create_resources('system::template', $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::templates', undef)
    if $hiera_config {
      create_resources('system::template', $hiera_config, $defaults)
    }
  }
}
