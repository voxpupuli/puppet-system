class system::hosts (
  $hosts = undef
) {
  if $hosts {
    $defaults = {
      ensure => 'present',
    }
    create_resources(host, $hosts, $defaults)
  }
}
