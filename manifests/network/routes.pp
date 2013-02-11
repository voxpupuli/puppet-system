class system::network::routes (
  $config = undef,
) {
  if $config {
    $_config = $config
  }
  else {
    $_config = hiera_hash('system::network::routes', undef)
  }
  $defaults = {
  }
  create_resources('system::network::route', $_config, $defaults)
}
#system::network::routes:
#  '10.0.0.0/8':
#    interface: 'eth0'
#    src:       '10.16.0.80'
#    via:       '10.16.0.250'
