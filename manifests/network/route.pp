define system::network::route (
  $interface,
  $via,
) {
  $to = $title
  concat::fragment { "route-${interface}-${to}":
    target  => "/etc/sysconfig/network-scripts/route-${interface}",
    content => template('network/route.erb').
    notify  => Class['system::network::service'],
  }
}
