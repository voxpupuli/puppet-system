class system::providers (
  $config = undef
) {
  if $config {
    if $config['host'] == 'augeas' {
      include augeasproviders
      Host { provider => 'augeas' }
    }
    if $config['mailalias'] == 'augeas' {
      include augeasproviders
      Mailalias { provider => 'augeas' }
    }
    if $config['mounttab'] == 'augeas' {
      include augeasproviders
      Mounttab { provider => 'augeas' }
    }
  }
}
