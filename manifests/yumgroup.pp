# Based on http://serverfault.com/questions/127460/how-do-i-install-a-yum-package-group-with-puppet
define system::yumgroup(
  $ensure   = "present",
  $optional = false
) {
  if ! defined(Package['yum-plugin-downloadonly']) {
    package { 'yum-plugin-downloadonly': ensure => installed }
  }
  $pkg_types_arg = $optional ? {
    true => "--setopt=group_package_types=optional,default,mandatory",
    default => ""
  }
  case $ensure {
    present,installed: {
      exec { "Installing $name yum group":
        command => "/usr/bin/yum -y groupinstall $pkg_types_arg '$name'",
        unless => "/usr/bin/yum -y groupinstall $pkg_types_arg '$name' --downloadonly",
        timeout => 600,
        require => Package["yum-plugin-downloadonly"],
      }
    }
    absent: {
      exec { "Removing $name yum group":
        command => "/usr/bin/yum -y groupremove $pkg_types_arg '$name'",
        unless => "/usr/bin/test -z \"$(/usr/bin/yum grouplist 2>/dev/null | perl -ne 'next if /^\s+\*/o; last if /^Available/; next if /^\w/o; next if /:/o; print' | grep -w '$name')\"",
        timeout => 600,
      }
    }
  }
}
