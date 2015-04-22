# = Class: system::yumrepos
#
# Manage yum repository files under /etc/yum.repos.d
#
# == Parameters:
#
# [*enabled*]
#   Enables or disables a YUM repository
#   Default: 1
#
# [*gpgcheck*]
#   Enables or disables GPG key checking
#   Default: 1
#
# [*schedule*]
#   Sets the schedule
#
class system::yumrepos (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    enabled  => '1',
    gpgcheck => '1',
    schedule => $schedule,
  }

  # only run this on RedHat-based OS (RHEL, CentOS)
  if $::osfamily == 'RedHat' {
    if $config {
      create_resources(yumrepo, $config, $defaults)
    }
    else {
      $hiera_config = hiera_hash('system::yumrepos', undef)
      if $hiera_config {
        create_resources(yumrepo, $hiera_config, $defaults)
      }
    }
  } else {
    debug("${::osfamily} does not have support for \"yumrepos\"")
  }
}
