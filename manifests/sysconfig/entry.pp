# = Class: system::sysconfig::entry
#
# Manages files under /etc/sysconfig
#
define system::sysconfig::entry (
  $file,
  $var,
  $val,
  $nudge = [],
  $schedule = undef,
) {

  warn "hello ${system::sysconfig_path}"

  if $val {
    augeas { "system-sysconfig-${file}-${var}":
      context  => "/files/etc/${system::sysconfig_path}/${file}",
      changes  => "set ${var} \"${val}\"",
      notify   => $nudge,
      schedule => $schedule,
    }
  }
}
