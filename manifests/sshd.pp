class system::sshd (
  $config         = undef,
  $sync_host_keys = 'true'
) {
  if $config {
    include augeasproviders
    $defaults = {}
    create_resources(sshd_config, $config, $defaults)
  }
  if $sync_host_keys == 'true' {
    # From: http://docs.puppetlabs.com/guides/exported_resources.html
    @@sshkey { [ $::hostname, $::fqdn ]: type => rsa, key => $::sshrsakey }
    Sshkey <<| |>>
  }
}
