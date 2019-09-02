class system::network::dns (
  Hash[String, Hash] $config = {},
) {

  if $config {
    $domains     = $config['domains']
    $nameservers = $config['nameservers']
    $options     = $config['options']
    assert_type(Array, $domains)
    assert_type(Array, $nameservers)
    assert_types(Array, $options)

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
