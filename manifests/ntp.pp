class system::ntp (
  $config   = undef,
  $schedule = $::system::schedule,
) {
  if $config {
    if $config['servers'] {
      class { '::ntp': servers => $config['servers'] }
    }
    elsif $config['country'] {
      class { '::ntp': country => $config['country'] }
    }
    elsif $config['continent'] {
      class { '::ntp': continent => $config['continent'] }
    }
    else {
      class { '::ntp': }
    }
  }
  else {
    $servers   = hiera('system::ntp::servers',   undef)
    $country   = hiera('system::ntp::country',   undef)
    $continent = hiera('system::ntp::continent', undef)
    if $servers {
      class { '::ntp': servers => $servers }
    }
    elsif $country {
      class { '::ntp': country => $country }
    }
    elsif $continent {
      class { '::ntp': continent => $continent }
    }
    else {
      class { '::ntp': }
    }
  }
}
