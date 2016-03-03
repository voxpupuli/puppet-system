# = Class: system::ssh_authorized_keys
#
# Manage ssh_authorized_key entries
#
class system::ssh_authorized_keys (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
    'type'     => 'ssh-rsa',
  }
  if $config {
    create_resources(ssh_authorized_key, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::ssh_authorized_keys', undef)
    if $hiera_config {
      create_resources(ssh_authorized_key, $hiera_config, $defaults)
    }
  }
}
