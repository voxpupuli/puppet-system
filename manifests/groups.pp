class system::groups {
  $groups = hiera_hash('groups', undef)
  if $groups {
    $defaults = {
      ensure => 'present',
    }
    create_resources(group, $groups, $defaults)
  }
}
