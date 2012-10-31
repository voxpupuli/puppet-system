class system::groups (
  $groups = undef
) {
  if $groups {
    $defaults = {
      ensure => 'present',
    }
    create_resources(group, $groups, $defaults)
  }
}
