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
  validate_string($_interface)
  if $dhcp == undef {
    if $ipaddress {
      $_dhcp = false
    }
    else {
      $_dhcp = true
    }
  }
  validate_bool($_dhcp)
  if $hwaddr {
    if ! is_mac_address($hwaddr) {
      fail("system::network::interface::hwaddr '$hwaddr' must be a MAC address: interface '${_interface}'")
    }
    $_hwaddr = $hwaddr
  }
  else {
    $_hwaddr = inline_template("<%= scope.lookupvar('macaddress_${_interface}') %>")
  }
  $_hotplug = $hotplug
  validate_bool($_hotplug)
  $_ipaddr  = $ipaddress
  if ! is_ip_address($_ipaddr) {
    fail('system::network::interface::ipaddress must be an IP address')
  }
  $_netmask = $netmask
  if ! is_ip_address($_netmask) {
    fail('system::network::interface::netmask must be an IP address')
  }
  $_onboot  = $onboot
  validate_bool($onboot)
  $_type    = $type
  validate_string($_type)
  if $_interface =~ /:/ {
    $_alias = true
  }
  else {
    $_alias = false
  }
  file { "/etc/sysconfig/network-scripts/ifcfg-${_interface}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('system/network/interface.erb'),
    #notify  => Class['system::network::service'],
  }
  if $routes {
    validate_hash($routes)
    concat { "/etc/sysconfig/network-scripts/route-${_interface}":
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }
    create_resources('system::network::route', $routes, { interface => $_interface } )
  }
}
