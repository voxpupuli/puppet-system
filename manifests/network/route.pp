define system::network::route (
  $interface,
  $via,
) {
  $to = $title
  validate_string($to)
  validate_string($interface)
  if ! is_ip_address($via) {
    fail('system::network::route::via must be an IP address')
  }
  concat::fragment { "route-${interface}-${to}":
    target  => "/etc/sysconfig/network-scripts/route-${interface}",
    content => template('system/network/route.erb'),
    #notify  => Class['system::network::service'],
  }
}
