class system::network::dns (
  Optional[hash] $config = undef,
) {
  if $config {
    $_config = $config
  }
  else {
    $_config = hiera_hash('system::network::dns', undef)
  }
  if $_config {
    $domains     = $_config['domains']
    $nameservers = $_config['nameservers']
    $options     = $_config['options']
    assert_type(Array, $domains)
    assert_type(Array, $nameservers)
    assert_type(Array, $options)
    file { '/etc/resolv.conf':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('system/network/dns.erb'),
    }
  }
}
#system::network::dns:
#  nameservers: [ '10.7.96.2'  ]
#  domains:     [ 'domain.com' ]
