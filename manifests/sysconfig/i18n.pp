class system::sysconfig::i18n (
  $config   = undef,
  $schedule = undef,
) {
  if $config {
    $i18n = $config
  }
  else {
    $i18n = hiera_hash('system::sysconfig::i18n', undef)
  }
  if $i18n {
    system::sysconfig::header { 'i18n':
      schedule => $schedule,
    }
    system::sysconfig::entry { 'i18n-lang':
      file     => 'i18n',
      var      => 'LANG',
      val      => $i18n['lang'],
      schedule => $schedule,
    }
    system::sysconfig::entry { 'i18n-sysfont':
      file     => 'i18n',
      var      => 'SYSFONT',
      val      => $i18n['sysfont'],
      schedule => $schedule,
    }
  }
}
