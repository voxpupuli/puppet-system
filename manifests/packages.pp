# = Class: system::packages
#
# Manage system package
#
# == Parameters:
#
# [*ensure*]
#   Sets the status of a package
#   Default: installed
#
class system::packages (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'installed',
    schedule => $schedule,
  }
  if $config {
    create_resources(package, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::packages', undef)
    if $hiera_config {
      create_resources(package, $hiera_config, $defaults)
    }
  }
}
