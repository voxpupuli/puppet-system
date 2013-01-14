class system::sysconfig::selinux (
  $config = undef
) {
  if $config {
    $selinux = $config
  }
  else {
    $selinux = hiera_hash('system::sysconfig::selinux')
  }
  if $selinux {
    sysselinux::header { 'selinux': }
    sysselinux::entry { 'selinux-state':
      file     => 'selinux',
      var      => 'SELINUX',
      val      => $selinux['state'],
      noquotes => true,
    }
    sysselinux::entry { 'selinux-type':
      file     => 'selinux',
      var      => 'SELINUXTYPE',
      val      => $selinux['type'],
      noquotes => true,
    }
  }
}
