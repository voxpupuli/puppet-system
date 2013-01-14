class system::sysconfig::i18n (
  $config = undef
) {
  if $config {
    $i18n = $config
  }
  else {
    $i18n = hiera_hash('system::sysconfig::i18n')
  }
  if $i18n {
    sysconfig::header { 'i18n': }
    sysconfig::entry { 'i18n-lang':
      file  => 'i18n',
      var   => 'LANG',
      val   => $i18n['lang']
    }
    sysconfig::entry { 'i18n-sysfont':
      file  => 'i18n',
      var   => 'SYSFONT',
      val   => $i18n['sysfont']
    }
  }
}
