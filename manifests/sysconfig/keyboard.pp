class system::sysconfig::keyboard (
  Hash[String, Hash] $config = {},
) {
  if $config {
    system::sysconfig::header { 'keyboard':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-keytable':
      file     => 'keyboard',
      var      => 'KEYTABLE',
      val      => $config['keytable'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-model':
      file     => 'keyboard',
      var      => 'MODEL',
      val      => $config['model'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-layout':
      file     => 'keyboard',
      var      => 'LAYOUT',
      val      => $config['layout'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'keyboard-keyboardtype':
      file     => 'keyboard',
      var      => 'KEYBOARDTYPE',
      val      => $config['keyboardtype'],
      schedule => $schedule,
    }
  }
}
