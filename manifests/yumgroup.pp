# Based on http://serverfault.com/questions/127460/how-do-i-install-a-yum-package-group-with-puppet
define system::yumgroup(
  $ensure   = 'present',
  $optional = false,
  $schedule = 'daily',
  $usecache = true
) {

  # only run this on RedHat-based OS (RHEL, CentOS)
  if $::osfamily == 'RedHat' {
    $pkg_types_arg = $optional ? {
      true    => '--setopt=group_package_types=optional,default,mandatory',
      default => '',
    }
    $cache = $usecache ? {
      true    => '-C',
      default => '',
    }
    case $ensure {
      present,installed: {
        exec { "Installing ${name} yum group":
          command  => "/usr/bin/yum -y groupinstall ${pkg_types_arg} '${name}'",
          unless   => "/usr/bin/yum ${cache} grouplist 2>/dev/null | /usr/bin/perl -ne 'last if /^Available/o; next if /^\\w/o; print' | /bin/grep -qw '${name}'", # lint:ignore:80chars
          timeout  => 600,
          schedule => $schedule,
        }
      }
      absent: {
        exec { "Removing ${name} yum group":
          command  => "/usr/bin/yum -y groupremove ${pkg_types_arg} '${name}'",
          unless   => "/usr/bin/yum ${cache} grouplist 2>/dev/null | /usr/bin/perl -ne 'last if /^Available/o; next if /^\\w/o; print' | /bin/grep -qw '${name}'", # lint:ignore:80chars
          timeout  => 600,
          schedule => $schedule,
        }
      }
      default: {
        fail('Unknown ensure value - valid values are: present, installed or absent') # lint:ignore:80chars
      }
    }
  } else {
    debug("${::osfamily} does not have support for \"yumgroup\"")
  }
}
