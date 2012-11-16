class system::sysconfig::keyboard (
  $config = undef
) {
  if $config {
    sysconfig::header { 'keyboard': }
    sysconfig::entry { 'keyboard-keytable':
      file  => 'keyboard',
      var   => 'KEYTABLE',
      val   => $config['keytable'],
    }
    sysconfig::entry { 'keyboard-model':
      file  => 'keyboard',
      var   => 'MODEL',
      val   => $config['model'],
    }
    sysconfig::entry { 'keyboard-layout':
      file  => 'keyboard',
      var   => 'LAYOUT',
      val   => $config['layout'],
    }
    sysconfig::entry { 'keyboard-keyboardtype':
      file  => 'keyboard',
      var   => 'KEYBOARDTYPE',
      val   => $config['keyboardtype'],
    }
  }
}
