class system::network::dns (
  $config = undef,
) {
  if $config {
    validate_hash($config)
    $_config = $config
  }
  else {
    $_config = hiera_hash('system::network::dns', undef)
  }
  if $_config {
    $domains     = $_config['domains']
    $nameservers = $_config['nameservers']
    validate_array($domains)
    validate_array($nameservers)
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
