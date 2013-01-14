class system::mailaliases (
  $config = undef
) {
  $defaults = {}
  if $config {
    create_resources(mailalias, $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::mailaliases')
    if $hiera_config {
      create_resources(mailalias, $hiera_config, $defaults)
    }
  }
}
