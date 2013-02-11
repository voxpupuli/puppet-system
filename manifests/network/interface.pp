define system::network::interface (
  $dhcp    = undef,
  $hwaddr  = undef,
  $hotplug = true,
  $ipaddr  = undef,
  $netmask = undef,
  $onboot  = true,
  $routes  = undef,
  $type    = 'Ethernet',
) {
  $_interface = $title
  if $dhcp == undef {
    if $ipaddress {
      $_dhcp = false
    }
    else {
      $_dhcp = true
    }
  }
  if $hwaddr {
    $_hwaddr = $hwaddr
  }
  else {
    $_hwaddr = scope.lookupvar("macaddress_${interface}")
  }
  $_hotplug = $hotplug
  $_ipaddr  = $ipaddr
  $_netmask = $netmask
  $_onboot  = $onboot
  $_type    = $type
  file { "/etc/sysconfig/network-scripts/ifcfg-${interface}":
    ensure => present,
    owner  => 'root',
    group  => 'root'
    mode   => '0644',
    content => template('system/network/interface.erb')
  }
  if $routes {
    concat { "/etc/sysconfig/network-scripts/route-${interface}":
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
    create_resources('system::network::route', $routes, { interface => $_interface } )
  }
}
