# = Class: system::network::service
#
# Manages network service
#
class system::network::service {
  service { 'network':
    ensure => 'running',
    enable => true,
  }
}
