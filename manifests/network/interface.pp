define system::network::interface (
  $dhcp      = undef,
  $hwaddr    = undef,
  $hotplug   = true,
  $ipaddress = undef,
  $netmask   = undef,
  $onboot    = true,
  $routes    = undef,
  $type      = 'Ethernet',
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
    $_hwaddr = inline_template("<%= scope.lookupvar('macaddress_${_interface}') %>")
  }
  $_hotplug = $hotplug
  $_ipaddr  = $ipaddress
  $_netmask = $netmask
  $_onboot  = $onboot
  $_type    = $type
  file { "/etc/sysconfig/network-scripts/ifcfg-${_interface}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('system/network/interface.erb'),
    notify  => Class['system::network::service'],
  }
  if $routes {
    concat { "/etc/sysconfig/network-scripts/route-${_interface}":
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
    create_resources('system::network::route', $routes, { interface => $_interface } )
  }
}
