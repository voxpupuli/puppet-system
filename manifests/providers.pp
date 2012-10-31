class system::providers (
  $providers = undef
) {
  if $providers {
    if $providers['host'] == 'augeas' {
      include augeasproviders
      Host { provider => 'augeas' }
    }
    if $providers['mailalias'] == 'augeas' {
      include augeasproviders
      Mailalias { provider => 'augeas' }
    }
    if $providers['mounttab'] == 'augeas' {
      include augeasproviders
      Mounttab { provider => 'augeas' }
    }
  }
}
