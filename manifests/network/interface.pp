define system::network::interface (
  $dhcp                                    = undef,
  Optional[Stdlib::MAC] $hwaddr            = undef,
  Boolean $hotplug                         = true,
  Optional[Stdlib::IP::Address] $ipaddress = undef,
  Boolean $ipv6init                        = false,
  $ipv6addr                                = undef,
  $ipv6addr_secondaries                    = undef,
  Boolean $ipv6autoconf                    = true,
  $netmask                                 = undef,
  Boolean $onboot                          = true,
  Optional[Hash] $routes                   = undef,
  String[1] $type                          = 'Ethernet',
  Boolean $userctl                         = false,
) {
  $_interface = $title
  assert_type(String[1], $_interface)
  if $dhcp == undef {
    if $ipaddress {
      $_dhcp = false
    }
    else {
      $_dhcp = true
    }
  }
  assert_type(Boolean, $_dhcp)
  if $hwaddr {
    $_hwaddr = $hwaddr
  }
  else {
    $_hwaddr = inline_template("<%= scope.lookupvar('macaddress_${_interface}') %>")
  }
  $_hotplug = $hotplug
  $_ipaddr  = $ipaddress
  if ! assert_type(Stdlib::IP::Address, $_ipaddr) and ! $_dhcp {
    fail('system::network::interface::ipaddress must be an IP address')
  }
  $_netmask = $netmask
  if ! assert_type(Stdlib::IP::Address, $_netmask) and ! $_dhcp {
    fail('system::network::interface::netmask must be an IP address')
  }
  $_onboot  = $onboot
  $_type    = $type
  if $_interface =~ /:/ {
    $_alias = true
  }
  else {
    $_alias = false
  }
  $_ipv6init = $ipv6init
  $_ipv6addr = $ipv6addr
  $_ipv6addr_secondaries = $ipv6addr_secondaries
  $_ipv6autoconf = $ipv6autoconf
  file { "/etc/sysconfig/network-scripts/ifcfg-${_interface}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('system/network/interface.erb'),
    #notify  => Class['system::network::service'],
  }
  if $routes {
    concat { "/etc/sysconfig/network-scripts/route-${_interface}":
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
    create_resources('system::network::route', $routes, { interface => $_interface })
  }
}
