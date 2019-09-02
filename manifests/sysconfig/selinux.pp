class system::sysconfig::selinux (
  Hash[String, Hash] $config = {},
) {
  if $config {
    system::sysconfig::header { 'selinux':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'selinux-state':
      file     => 'selinux',
      var      => 'SELINUX',
      val      => $config['state'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'selinux-type':
      file     => 'selinux',
      var      => 'SELINUXTYPE',
      val      => $config['type'],
      schedule => $schedule,
    }
  }
}
