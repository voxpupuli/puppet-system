define system::network::route (
  String[1] $interface,
  Stdlib::IP::Address $via,
) {
  $to = $title
  assert_type(String[1], $to)
  concat::fragment { "route-${interface}-${to}":
    target  => "/etc/sysconfig/network-scripts/route-${interface}",
    content => template('system/network/route.erb'),
  }
}
