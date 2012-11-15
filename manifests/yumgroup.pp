# Based on http://serverfault.com/questions/127460/how-do-i-install-a-yum-package-group-with-puppet
define system::yumgroup(
  $ensure   = 'present',
  $optional = false
) {
  $pkg_types_arg = $optional ? {
    true    => '--setopt=group_package_types=optional,default,mandatory',
    default => '',
  }
  case $ensure {
    present,installed: {
      exec { "Installing ${name} yum group":
        command => "/usr/bin/yum -y groupinstall ${pkg_types_arg} '${name}'",
        unless  => "/root/yum-installed-groups is_installed '${name}'",
        timeout => 600,
        require => File['/root/yum-installed-groups'],
      }
    }
    absent: {
      exec { "Removing ${name} yum group":
        command => "/usr/bin/yum -y groupremove ${pkg_types_arg} '${name}'",
        unless  => "/root/yum-installed-groups is_not_installed '${name}'",
        timeout => 600,
        require => File['/root/yum-installed-groups'],
      }
    }
    default: {
      fail('Unknown ensure value - valid values are: present, installed or absent')
    }
  }
}
