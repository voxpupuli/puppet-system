class system::limits (
  $limits = undef
) {
  if $limits {
    include limits
    class { '::limits':
      config    => $limits,
      use_hiera => false,
    }
  }
}
