define system::network::interface (
  $dhcp    = undef,
  $hwaddr  = undef,
  $ipaddr  = undef,
  $inboot  = true,
  $hotplug = true,
  $netmask = true,
  $type    = 'Ethernet',
) {
  file { "/etc/sysconfig/network-scripts/ifcfg-${interface}":
    ensure => present,
    owner  => 'root',
    group  => 'root'
    mode   => '0644',
    content => template('system/network/interface.erb')
  }
  if $dhcp == undef {
    if $ipaddress {
      $_dhcp = false
    }
    else {
      $_dhcp = true
    }
  }
}
#system::network::interfaces:
#  eth0:
#    dhcp:    'false' # default
#    hwaddr:  '00:50:56:AF:01:1A' # defaults to: macaddress_eth0
#    onboot:  'true' # default
#    hotplug: 'true' # default
#    type:    'Ethernet' # default
#    ipaddr:  '10.7.96.21'
#    netmask: '255.255.240.0'
