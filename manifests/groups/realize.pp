class system::groups::realize (
  $groups   = undef,
  $sys_schedule = 'always',
) {
  if $groups {
    realize(Group[$groups])
  }
  else {
    $hiera_groups = hiera_array('system::groups::realize', undef)
    if $hiera_groups {
      realize(Group[$hiera_groups])
    }
  }
}
