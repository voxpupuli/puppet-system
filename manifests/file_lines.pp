
class system::file_lines (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  $defaults = {
    ensure   => 'present',
    schedule => $schedule,
  }
  if $config {
    create_resources(file_lines, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::file_lines', undef)
    if $hiera_config {
      create_resources(file_line, $hiera_config, $defaults)
    }
  }
}

