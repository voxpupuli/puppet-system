define system::sysconfig::entry (
  $file,
  $var,
  $val,
  $nudge = [],
  $schedule = undef,
) {
  if $val {
    augeas { "system-sysconfig-${file}-${var}":
      context  => "/files/etc/sysconfig/${file}",
      changes  => "set ${var} \"${val}\"",
      notify   => $nudge,
      schedule => $schedule,
    }
  }
}
