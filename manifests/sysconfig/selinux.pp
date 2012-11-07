class system::sysconfig::selinux (
  $config = undef
) {
  if $config {
    $state = $config['state'] ? {
      undef   => 'enforcing',
      default => $config['state'],
    }
    $type = $config['type'] ? {
      undef   => 'targeted',
      default => $config['type'],
    }
    file { '/etc/selinux/config':
      ensure  => present,
      #content => "# Managed by puppet\nSELINUX=\"${state}\"\nSELINUXTYPE=\"${type}\"\n",
      content => template('system/sysconfig/selinux.erb'),
    }
  }
}
