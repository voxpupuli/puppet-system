class system::schedules (
  Hash[String, Hash] $config = {},
) {
  $defaults = {}

  create_resources(schedule, $config, $defaults)

  schedule { 'always':
    range => '0 - 23',
  }
}
