class system::sysconfig::i18n (
  $config = undef
) {
  if $config {
    $lang = $config['lang'] ? {
      undef   => 'en_US.UTF-8',
      default => $config['lang'],
    }
    $sysfont  = $config['sysfont'] ? {
      undef   => 'latarcyrheb-sun16',
      default => $config['sysfont'],
    }
    file { '/etc/sysconfig/i18n':
      ensure  => present,
      #content => "# Managed by puppet\nLANG=\"${lang}\"\nSYSFONT=\"${sysfont}\"\n",
      content => template('system/sysconfig/i18n.erb'),
    }
  }
}
