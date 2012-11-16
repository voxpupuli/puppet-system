class system::sysconfig::selinux (
  $config = undef
) {
  if $config {
    sysconfig::header { 'selinux': }
    sysconfig::entry { 'selinux-state':
      file     => 'selinux',
      var      => 'SELINUX',
      val      => $config['state'],
      noquotes => true,
    }
    sysconfig::entry { 'selinux-type':
      file     => 'selinux',
      var      => 'SELINUXTYPE',
      val      => $config['type'],
      noquotes => true,
    }
  }
}
