define system::network::route (
  String $interface,
  Stdlib::Compat::Ip_address $via,
) {
  $to = $title
  concat::fragment { "route-${interface}-${to}":
    target  => "/etc/sysconfig/network-scripts/route-${interface}",
    content => template('system/network/route.erb'),
    #notify  => Class['system::network::service'],
  }
}
