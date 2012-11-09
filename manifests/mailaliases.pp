class system::mailaliases (
  $config = undef
) {
  if $config {
    $defaults = { }
    create_resources(mailalias, $config, $defaults)
  }
}
