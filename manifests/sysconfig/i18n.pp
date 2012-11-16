class system::sysconfig::i18n (
  $config = undef
) {
  if $config {
    sysconfig::header { 'i18n': }
    sysconfig::entry { 'i18n-lang':
      file  => 'i18n',
      var   => 'LANG',
      val   => $config['lang']
    }
    sysconfig::entry { 'i18n-sysfont':
      file  => 'i18n',
      var   => 'SYSFONT',
      val   => $config['sysfont']
    }
  }
}
