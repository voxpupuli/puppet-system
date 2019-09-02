class system::sysconfig::i18n (
  Hash[String, Hash] $config = {},
) {
  if $config {
    system::sysconfig::header { 'i18n':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'i18n-lang':
      file     => 'i18n',
      var      => 'LANG',
      val      => $config['lang'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'i18n-sysfont':
      file     => 'i18n',
      var      => 'SYSFONT',
      val      => $config['sysfont'],
      schedule => $schedule,
    }
  }
}
