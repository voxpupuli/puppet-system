class system::groups {
  $defaults = {
    ensure => 'present',
  }
  create_resources(group, hiera_hash('groups'), $defaults)
}
