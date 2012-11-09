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
}
