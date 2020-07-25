define system::template (
  $template,
  $owner    = 'root',
  $group    = 'root',
  $mode     = undef,
  $sys_schedule = 'always',
) {
  file { $title:
    owner    => $owner,
    group    => $group,
    mode     => $mode,
    schedule => $sys_schedule,
    content  => template($template),
  }
}
