class system::network::service {
  service { 'network':
    ensure => 'running',
    enable => true,
  }
}
