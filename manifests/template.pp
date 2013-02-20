define system::template(
  $template,
  $owner    = 'root',
  $group    = 'root',
  $mode     = undef,
  $schedule = 'always',
  $usecache = true
) {
  file { $title:
    owner    => $owner,
    group    => $group,
    mode     => $mode,
    schedule => $schedule,
    content  => template($template),
  }
}
