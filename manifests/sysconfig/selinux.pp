class system::sysconfig::selinux (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $selinux = $config
  }
  else {
    $selinux = hiera_hash('system::sysconfig::selinux', undef)
  }
  if $selinux {
    system::sysconfig::header { 'selinux':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'selinux-state':
      file     => 'selinux',
      var      => 'SELINUX',
      val      => $selinux['state'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'selinux-type':
      file     => 'selinux',
      var      => 'SELINUXTYPE',
      val      => $selinux['type'],
      schedule => $schedule,
    }
  }
}
