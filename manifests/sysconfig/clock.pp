class system::sysconfig::clock (
  $config = undef
) {
  if $config {
    sysconfig::header { 'clock': }
    sysconfig::entry { 'clock-zone':
      file  => 'clock',
      var   => 'ZONE',
      val   => $config['timezone'],
      nudge => Exec['/etc/localtime'],
    }
    exec { '/etc/localtime':
      command     => "/bin/rm -f /etc/localtime && /bin/cp /usr/share/zoneinfo/${timezone} /etc/localtime",
      refreshonly => true,
    }
  }
}
