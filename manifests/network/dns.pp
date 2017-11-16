# Create resolv.conf file utilizing the template/dns.erb
# The resolv.conf has basically 3 parts:
#  nameservers
#  domains
#  options
#
# If specified, each of these should be an array of strings
# None of them are actually required.  See resolv.conf(5)
#
# For simplicity, this implementation always uses the 
# "search" keyword with the values for "domains"

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
    $domains     = pick($_config['domains'],[])
    $nameservers = pick($_config['nameservers'],[])
    $options     = pick($_config['options'],[])
    validate_array($domains)
    validate_array($nameservers)
    validate_array($options)
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
