# = Class: system::yumgroups
#
# Manage system package groups
#
# == Parameters:
#
# [*optional*]
#   Makes a YUM group optional
#   Default: false
#
# [*usecache*]
#   Enables or disables the use of the cache
#   Default: true
#
# [*schedule*]
#   Sets the schedule
#   Default: daily
#
class system::yumgroups (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources('system::yumgroup', $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::yumgroups', undef)
    if $hiera_config {
      create_resources('system::yumgroup', $hiera_config, $defaults)
    }
  }
}
