define sysconfig::entry (
  $file,
  $var,
  $val,
  $nudge = [],
  $noquotes = false
) {
  if $val {
    # Files like /etc/sysconfig/selinux don't work with quoted values
    if $noquotes {
      # If there is an existing entry then replace the value
      exec { "sysconfig-replace-${file}-${var}":
        command => "/usr/bin/perl -pi -e 's#^${var}=.*?$#${var}=${val}#' /etc/sysconfig/${file}",
        unless  => "/bin/grep -w '^${var}=${val}' /etc/sysconfig/${file}",
        require => File["/etc/sysconfig/${file}"],
        notify  => $nudge
      }
      # Otherwise add a new entry
      exec { "sysconfig-add-${file}-${var}":
        command => "/bin/echo '${var}=${val}' >> /etc/sysconfig/${file}",
        unless  => "/bin/grep -w '^${var}=${val}' /etc/sysconfig/${file}",
        require => Exec["sysconfig-replace-${file}-${var}"],
        notify  => $nudge
      }
    }
    else {
      # If there is an existing entry then replace the value
      exec { "sysconfig-replace-${file}-${var}":
        command => "/usr/bin/perl -pi -e 's#^${var}=.*?$#${var}=\"${val}\"#' /etc/sysconfig/${file}",
        unless  => "/bin/grep -w '^${var}=\"${val}\"' /etc/sysconfig/${file}",
        require => File["/etc/sysconfig/${file}"],
        notify  => $nudge
      }
      # Otherwise add a new entry
      exec { "sysconfig-add-${file}-${var}":
        command => "/bin/echo '${var}=\"${val}\"' >> /etc/sysconfig/${file}",
        unless  => "/bin/grep -w '^${var}=\"${val}\"' /etc/sysconfig/${file}",
        require => Exec["sysconfig-replace-${file}-${var}"],
        notify  => $nudge
      }
    }
  }
}
