define system::template(
  $template,
  $owner    = 'root',
  $group    = 'root',
  $mode     = undef,
  $sys_schedule = 'always',
) {
  if $template =~ /.epp$/ {
    file { $title:
    owner    => $owner,  
    group    => $group,
    mode     => $mode,
    schedule => $sys_schedule,
    content  => epp($template),
    }
  } else {
  #elsif $template =~ /.erb$/ 
      file { $title:
      owner    => $owner,
      group    => $group,
      mode     => $mode,
      schedule => $sys_schedule,
      content  => template($template),
    }
  }
}
