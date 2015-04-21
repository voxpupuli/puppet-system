# = Class: system::sysconfig::header
#
# Adds header to files managed by system::sysconfig
#
define system::sysconfig::header (
  $schedule = undef,
) {
  $file = $title
  exec { "sysconfig-${file}-empty":
    command  => "/bin/echo > ${system::sysconfig_path}/${file}",
    unless   => "/usr/bin/test -s ${system::sysconfig_path}/${file}",
    schedule => $schedule,
  }
  exec { "sysconfig-${file}-header":
    command  => "/bin/sed -i '1i# Managed by puppet' ${system::sysconfig_path}/${file}", # lint:ignore:80chars
    unless   => "/bin/grep -w '^# Managed by puppet' ${system::sysconfig_path}/${file}", # lint:ignore:80chars
    require  => Exec["sysconfig-${file}-empty"],
    schedule => $schedule,
  }
}
