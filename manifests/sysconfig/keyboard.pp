class system::sysconfig::keyboard (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $keyboard = $config
  }
  else {
    $keyboard = hiera_hash('system::sysconfig::keyboard', undef)
  }
  if $keyboard {
    system::sysconfig::header { 'keyboard':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-keytable':
      file  => 'keyboard',
      var   => 'KEYTABLE',
      val   => $keyboard['keytable'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-model':
      file  => 'keyboard',
      var   => 'MODEL',
      val   => $keyboard['model'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-layout':
      file  => 'keyboard',
      var   => 'LAYOUT',
      val   => $keyboard['layout'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-keyboardtype':
      file  => 'keyboard',
      var   => 'KEYBOARDTYPE',
      val   => $keyboard['keyboardtype'],
      schedule => $schedule,
    }
  }
}
