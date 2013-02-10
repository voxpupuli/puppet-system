class system::limits (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  if $config {
    include limits
    class { '::limits':
      config    => $config,
      use_hiera => false,
      #schedule => $schedule,
    }
  }
  else {
    $hiera_config = hiera_hash('system::limits', undef)
    if $hiera_config {
      include limits
      class { '::limits':
        config    => $hiera_config,
        use_hiera => false,
        #schedule => $schedule,
      }
    }
  }
}
