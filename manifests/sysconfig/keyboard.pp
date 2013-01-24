class system::sysconfig::keyboard (
  $config = undef
) {
  if $config {
    $keyboard = $config
  }
  else {
    $keyboard = hiera_hash('system::sysconfig::keyboard', undef)
  }
  if $keyboard {
    system::sysconfig::header { 'keyboard': }
    system::sysconfig::entry { 'keyboard-keytable':
      file  => 'keyboard',
      var   => 'KEYTABLE',
      val   => $keyboard['keytable'],
    }
    system::sysconfig::entry { 'keyboard-model':
      file  => 'keyboard',
      var   => 'MODEL',
      val   => $keyboard['model'],
    }
    system::sysconfig::entry { 'keyboard-layout':
      file  => 'keyboard',
      var   => 'LAYOUT',
      val   => $keyboard['layout'],
    }
    system::sysconfig::entry { 'keyboard-keyboardtype':
      file  => 'keyboard',
      var   => 'KEYBOARDTYPE',
      val   => $keyboard['keyboardtype'],
    }
  }
}
