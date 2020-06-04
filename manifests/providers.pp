class system::providers (
  $config   = undef,
) {
  if $config {
    $_config = $config
  }
  else {
    $_config = hiera_hash('system::providers', undef)
  }
  if $_config {
    if $config['host'] == 'augeas' {
      Host { provider => 'augeas' }
    }
    if $config['mailalias'] == 'augeas' {
      Mailalias { provider => 'augeas' }
    }
    if $config['mounttab'] == 'augeas' {
      Mounttab { provider => 'augeas' }
    }
  }
}
