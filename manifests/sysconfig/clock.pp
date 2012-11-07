class system::sysconfig::clock (
  $config = undef
) {
  if $config {
    $timezone = $config['timezone']
    file { '/etc/sysconfig/clock':
      ensure  => present,
      #content => "# Managed by puppet\nZONE=\"${timezone}\"\n",
      content => template('system/sysconfig/clock.erb'),
      notify  => Exec['/etc/localtime'],
    }
    exec { '/etc/localtime':
      command     => "/bin/rm -f /etc/localtime && /bin/cp /usr/share/zoneinfo/${timezone} /etc/localtime",
      refreshonly => true,
    }
  }
}
