class system::mailaliases (
  $mailaliases = undef
) {
  if $mailaliases {
    $defaults = { }
    create_resources(mailalias, $mailaliases, $defaults)
  }
}
