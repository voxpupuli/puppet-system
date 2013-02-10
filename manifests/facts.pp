class system::facts (
  $config   = undef,
  $cleanold = false,
  $schedule = $::system::schedule,
) {
  if ! defined(File['/etc/facter']) {
    file { '/etc/facter':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }
  if ! defined(File['/etc/facter/facts.d']) {
    file { '/etc/facter/facts.d':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => File['/etc/facter'],
    }
  }
  include concat::setup
  concat { '/etc/facter/facts.d/system_facts.yaml':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/facter/facts.d'],
  }
  concat::fragment { 'system_facts_header':
    target   => '/etc/facter/facts.d/system_facts.yaml',
    content  => "---\n",
    order    => '01',
  }
  $defaults = {
    schedule => $schedule,
  }
  if $config {
    create_resources('system::fact', $config, $defaults)
  }
  else {
    $hiera_config = hiera_hash('system::facts', undef)
    if $hiera_config {
      create_resources('system::fact', $hiera_config, $defaults)
    }
  }

  if $cleanold {
    # Clean up facts from old locations
    $sh_filename  = '/etc/profile.d/custom_facts.sh'
    $csh_filename = '/etc/profile.d/custom_facts.csh'
    file { [ $sh_filename, $csh_filename ]:
      ensure => absent,
    }
    exec { "fact-remove-sysconfig-puppet":
      command  => "/usr/bin/perl -pi -e 's/^\s*#?\s*(export )?FACTER_.*?=.*?$//' /etc/sysconfig/puppet",
      onlyif   => '/bin/grep -q FACTER_ /etc/sysconfig/puppet',
      schedule => $schedule,
    }
  }
}
