class system::ntp (
  $ntp = undef
) {
  if $ntp {
    include ntp
    class { '::ntp':
      use_hiera => false,
      servers   => $ntp['servers'],
      country   => $ntp['country'],
      continent => $ntp['continent'],
    }
  }
}
