class system::crontabs (
  $config = undef
) {
  if $config {
    $defaults = {
      ensure => 'present',
      user   => 'root',
    }
    create_resources(cron, $config, $defaults)
  }
}
