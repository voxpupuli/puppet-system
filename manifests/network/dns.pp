class system::network::dns (
  $config = undef,
) {
  if $config {
    $_config = $config
  }
  else {
    $_config = hiera_hash('system::network::dns', undef)
  }
  $domains     = $_config['domains']
  $nameservers = $_config['nameservers']
  file { '/etc/resolv.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('system/network/dns.erb'),
  }
}
#system::network::dns:
#  nameservers: [ '10.7.96.2'  ]
#  domains:     [ 'domain.com' ]
#system::network::interfaces:
#    eth0:
#      dhcp:    'false' # default
#      hwaddr:  '00:50:56:AF:01:1A' # defaults to: macaddress_eth0
#      onboot:  'true' # default
#      hotplug: 'true' # default
#      type:    'Ethernet' # default
#      ipaddr:  '10.7.96.21'
#      netmask: '255.255.240.0'
#system::network::routes:
#  '10.0.0.0/8':
#    dev: 'eth0'
#    src: '10.16.0.80'
#    via: '10.16.0.250'
