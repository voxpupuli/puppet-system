define system::template(
  $template,
  String $owner        = 'root',
  String $group        = 'root',
  $mode                = undef,
  String $sys_schedule = 'always',
) {
  file { $title:
    owner    => $owner,
    group    => $group,
    mode     => $mode,
    schedule => $sys_schedule,
    content  => template($template),
  }
}
