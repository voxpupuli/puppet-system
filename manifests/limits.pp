class system::limits (
  $config = undef
) {
  if $config {
    include limits
    class { '::limits':
      config    => $config,
      use_hiera => false,
    }
  }
  else {
    $hiera_config = hiera_hash('system::limits')
    if $hiera_config {
      include limits
      class { '::limits':
        config    => $hiera_config,
        use_hiera => false,
      }
    }
  }
}
