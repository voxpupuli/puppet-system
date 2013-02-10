define system::fact (
  $value    = undef,
  $schedule = $::system::schedule,
  $type     = 'yaml',
  $ttl      = undef,
) {
  # This uses facter_dot_d which is a Facter plugin that loads facts from
  # /etc/facter/facts.d
  $var = $title
  if is_array($value) {
    $resource_name = "${var}%index%"
    $parameters = {
      schedule => $schedule,
      type     => $type,
      ttl      => $ttl,
    }
    $dynamic_parameters = {
      'value' => '%s'
    }
    $created_resource_hash =
      create_resources_hash_from($resource_name, $value, $parameters, $dynamic_parameters)
    create_resources('system::fact', $created_resource_hash)
  }
  else {
    case $type {
      'script': {
        file { "/etc/facter/facts.d/system_facts_${var}.sh":
          owner    => 'root',
          group    => 'root',
          mode     => '0744',
          content  => $value,
        }
        if $ttl {
          file { "/etc/facter/facts.d/system_facts_${var}.sh.ttl":
            owner    => 'root',
            group    => 'root',
            mode     => '0744',
            content  => "${ttl}\n",
          }
        }
      }
      default: {
        concat::fragment { "system_facts_${var}":
          target   => '/etc/facter/facts.d/system_facts.yaml',
          content  => "${var}: ${value}\n",
          order    => '02',
        }
      }
    }
  }
}
