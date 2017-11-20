class system::network (
  Optional[String] $hostname                    = undef,
  Optional[Stdlib::Compat::Ip_address] $gateway = undef,
  Boolean $ipv6                                 = false,
  $ipv6init                                     = false,
  $ipv6autoconf                                 = true,
  Boolean $zeroconf                             = false,
) {

  if $hostname {
    assert_type(Stdlib::Compat::Ip_address, $gateway)
    file { '/etc/sysconfig/network':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('system/network/network.erb'),
    }
    include ::system::network::dns
    include ::system::network::interfaces
    include ::system::network::service
  }
}
