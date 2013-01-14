class system::sysconfig::keyboard (
  $config = undef
) {
  if $config {
    $keyboard = $config
  }
  else {
    $keyboard = hiera_hash('system::sysconfig::keyboard')
  }
  if $keyboard {
    syskeyboard::header { 'keyboard': }
    syskeyboard::entry { 'keyboard-keytable':
      file  => 'keyboard',
      var   => 'KEYTABLE',
      val   => $keyboard['keytable'],
    }
    syskeyboard::entry { 'keyboard-model':
      file  => 'keyboard',
      var   => 'MODEL',
      val   => $keyboard['model'],
    }
    syskeyboard::entry { 'keyboard-layout':
      file  => 'keyboard',
      var   => 'LAYOUT',
      val   => $keyboard['layout'],
    }
    syskeyboard::entry { 'keyboard-keyboardtype':
      file  => 'keyboard',
      var   => 'KEYBOARDTYPE',
      val   => $keyboard['keyboardtype'],
    }
  }
}
