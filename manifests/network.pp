class system::network (
  $hostname,
  $gateway,
  $ipv6       = false,
  $zeroconf   = false,
) {
  file { '/etc/sysconfig/network':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('system/network/network.erb'),
  }
  include system::network::dns
  include system::network::interfaces
  include system::network::service
}
