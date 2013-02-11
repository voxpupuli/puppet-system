class system::users::realize (
  $users    = [],
  $schedule = $::system::schedule,
) {
  if $users {
    realize(User[$users])
  }
  else {
    $hiera_users = hiera_array('system::users::realize', undef)
    if $hiera_users {
      realize(User[$hiera_users])
    }
  }
}
