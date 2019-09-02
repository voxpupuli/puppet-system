class system::providers (
  Hash[String, Hash] $config = {},
) {
  if $config['host'] == 'augeas' {
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
