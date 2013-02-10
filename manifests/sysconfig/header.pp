define system::sysconfig::header (
  $schedule = undef,
) {
  $file = $title
  exec { "sysconfig-${file}-empty":
    command  => "/bin/echo > /etc/sysconfig/${file}",
    unless   => "/usr/bin/test -s /etc/sysconfig/${file}",
    schedule => $schedule,
  }
  exec { "sysconfig-${file}-header":
    command  => "/bin/sed -i '1i# Managed by puppet' /etc/sysconfig/${file}",
    unless   => "/bin/grep -w '^# Managed by puppet' /etc/sysconfig/${file}",
    require  => Exec["sysconfig-${file}-empty"],
    schedule => $schedule,
  }
}
