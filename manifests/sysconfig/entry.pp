define system::sysconfig::entry (
  $file,
  $var,
  $val,
  $nudge = [],
) {
  if $val {
    augeas { "system-sysconfig-${file}-${var}":
      context => "/files/etc/sysconfig/${file}",
      changes => "set ${var} \"${val}\"",
      notify  => $nudge,
    }
  }
}
