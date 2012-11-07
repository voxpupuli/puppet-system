class system::sysconfig::keyboard (
  $config = undef
) {
  if $config {
    $keytable = $config['keytable'] ? {
      undef   => 'uk',
      default => $config['keytable'],
    }
    $model = $config['model'] ? {
      undef   => 'pc105',
      default => $config['model'],
    }
    $layout = $config['layout'] ? {
      undef   => 'gb',
      default => $config['layout'],
    }
    $keyboardtype = $config['keyboardtype'] ? {
      undef   => 'pc',
      default => $config['keyboardtype'],
    }
    file { '/etc/sysconfig/keyboard':
      ensure  => present,
      #content => "# Managed by puppet\nKEYTABLE=\"${keytable}\"\nMODEL=\"${model}\"\nLAYOUT=\"${layout}\"\nKEYBOARDTYPE=\"${keyboardtype}\"\n",
      content => template('system/sysconfig/keyboard.erb'),
    }
  }
}
