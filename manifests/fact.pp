define system::fact (
  $value = undef
) {
  $var = "FACTER_${title}"

  # Add to /etc/sysconfig/puppet so the puppet agent picks it up
  system::sysconfig::entry { "system-fact-${title}":
    file  => 'puppet',
    var   => "export ${var}",
    val   => $value,
  }

  $sh_filename  = '/etc/profile.d/custom_facts.sh'

  # If there is an existing entry then replace the value
  exec { "fact-replace-${title}-sh":
    command => "/usr/bin/perl -pi -e 's#^\s*\#?\s*(export )?${var}=.*?$#export ${var}=\"${value}\"#' ${sh_filename}",
    unless  => "/bin/grep -w '^export ${var}=\"${value}\"' ${sh_filename}",
  }
  # Otherwise add a new entry
  exec { "fact-add-${title}-sh":
    command => "/bin/echo 'export ${var}=\"${value}\"' >> ${sh_filename}",
    unless  => "/bin/grep -w '^export ${var}=\"${value}\"' ${sh_filename}",
    require => Exec["fact-replace-${title}-sh"],
  }

  $csh_filename = '/etc/profile.d/custom_facts.csh'

  # If there is an existing entry then replace the value
  exec { "fact-replace-${title}-csh":
    command => "/usr/bin/perl -pi -e 's#^\s*\#?\s*(setenv )${var}\s+.*?$#setenv ${var} \"${value}\"#' ${sh_filename}",
    unless  => "/bin/grep -w '^setenv ${var} \"${value}\"' ${csh_filename}",
  }
  # Otherwise add a new entry
  exec { "fact-add-${title}-csh":
    command => "/bin/echo 'setenv ${var} \"${value}\"' >> ${csh_filename}",
    unless  => "/bin/grep -w '^setenv ${var} \"${value}\"' ${csh_filename}",
    require => Exec["fact-replace-${title}-csh"],
  }
}
