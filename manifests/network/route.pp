define system::network::route (
  $interface,
  $via,
  $src = undef
) {
  $to = $title
  # concat fragment /etc/sysconfig/network-scripts/route-${interface}
}
#system::network::routes:
#  '10.0.0.0/8':
#    interface: 'eth0'
#    src:       '10.16.0.80'
#    via:       '10.16.0.250'
