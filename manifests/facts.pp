class system::facts (
  $config = undef
) {
  if $config {
    $defaults = {}
    create_resources('system::fact', $config, $defaults)
  }
}
