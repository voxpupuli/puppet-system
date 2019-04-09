class system::network (
  Optional[String[1]] $hostname          = undef,
  Optional[Stdlib::IP::Address] $gateway = undef,
  Boolean $ipv6                          = false,
  Boolean $ipv6init                      = false,
  Boolean $ipv6autoconf                  = true,
  Boolean $zeroconf                      = false,
) {
  if $hostname {
    assert_type(Stdlib::IP::Address, $gateway)

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
}
