class system::crontabs (
  $config = undef
) {
  $defaults = {
    ensure => 'present',
    user   => 'root',
  }
  if $config {
    create_resources(cron, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::cron')
    if $hiera_config {
      create_resources(cron, $hiera_config, $defaults)
    }
  }
}
