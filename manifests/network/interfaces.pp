class system::network::interfaces (
  $config = undef,
) {
  if $config {
    $_config = $config
  }
  else {
    $_config = hiera_hash('system::network::interfaces', undef)
  }
  $defaults = {
  }
  create_resources('system::network::interface', $_config, $defaults)
}
#system::network::interfaces:
#  eth0:
#  dhcp:    'false' # default
#  hwaddr:  '00:50:56:AF:01:1A' # defaults to: macaddress_eth0
#  onboot:  'true' # default
#  hotplug: 'true' # default
#  type:    'Ethernet' # default
#  ipaddr:  '10.7.96.21'
#  netmask: '255.255.240.0'
