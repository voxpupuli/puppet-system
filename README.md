# puppet-system

Manage system resources (users, groups, mounts, yum repositories, packages,
hosts, mail aliases) and configuration (syslog, limits, sshd) using hiera
configuration.

## Documentation

For default types (users, groups, mounts, yumrepos, packages) see the
documentation at http://docs.puppetlabs.com/references/latest/type.html for the
parameters that can be passed to each of the resources.

For augeasproviders types (sysctl, syslog, sshd) see
http://forge.puppetlabs.com/domcleal/augeasproviders.

For limits see http://forge.puppetlabs.com/erwbgy/limits.

## Usage

Include the system module in your puppet configuration:

    include system

and add required hiera configuration.

## groups

Managed local groups

Example configuration:

    system:
      groups:
        'keith':
          ensure: 'present'
          gid:    '500'
        'fred':
          gid:    '503'
 
Defaults:

* ensure: present

## hosts

Manage entries in /etc/hosts

Example configuration:

    system:
      hosts:
        puppet:
          ensure:       'present'
          ip:           '10.5.11.19'
          host_aliases: [ 'puppet.local' ]

Defaults:
* ensure: present

See: http://docs.puppetlabs.com/references/latest/type.html#host

## limits

Manages entries in /etc/security/limits.conf

Example configuration:

     system:
       limits:
         '*':
           item: 'nofile'
           soft: '2048'
           hard: '8192'
         '@mygroup':
           item: 'nproc'
           soft: '20'
           hard: '50'

No defaults.

## mailaliases

Manage entries in /etc/aliases

Example configuration:

    system:
      mailaliases:
        postmaster:
          recipient: 'root'
        webmaster:
          recipient: 'fred@domain.com'

No defaults.

See: http://docs.puppetlabs.com/references/latest/type.html#mailalias

## mounts

Manage entries in /etc/fstab

Example configuration:

    system:
      mounts:
        '/home':
          ensure:  'mounted'
          device:  '/dev/mapper/vg_x120-lv_home'
          atboot:  'true'
          fstype:  'ext4'
          options: 'defaults'

Defaults:

* atboot: true
* ensure: mounted

## packages

Manage system packages

Example configuration:

    system:
      packages:
        AdobeReader_enu:
          ensure: '9.5.1-1'
        ConsoleKit:
          ensure: '0.4.5-2.fc17'

Defaults:

* ensure: installed

## sshd

Manage /etc/ssh/sshd.conf settings.

Example configuration:

    system:
      sshd:
        config:
          AllowGroups: [ 'sshusers', 'admin' ]
          PermitRootLogin:
            value:     'without-password'
            condition: 'Host example.net'
        subsystem:
          sftp:
            command: '/usr/libexec/openssh/sftp-server'

No defaults.

See:

* https://github.com/domcleal/augeasproviders/blob/master/lib/puppet/type/sshd_config.rb
* https://github.com/domcleal/augeasproviders/blob/master/lib/puppet/type/sshd_config_subsystem.rb

## sysctl

Manage settings in /etc/sysctl.conf

Example configuration:

    system:
      sysctl:
        kernel.msgmnb:
          value: '131072'
          comment: 'Controls the default maxmimum size of a message queue'
        kernel.msgmax:
          value: '131072'
          comment: ' Controls the maximum size of a message, in bytes'

No defaults.

See:

* https://github.com/domcleal/augeasproviders/blob/master/lib/puppet/type/sysctl.rb

## syslog

Manages settings in syslog.conf

TODO - I use rsyslog

Example configuration:

    system:
      syslog:

## users

Manages local users

Example configuration:

    system:
      users:
        'keith':
          ensure:    'present'
          comment:   'Keith Burdis'
          gid:       '500'
          groups:    ['wheel']
          home:      '/home/keith'
          shell:     '/bin/bash'
          uid:       '500'
        'fred':
          comment:   'Fred Bloggs'
          uid:       '503'
          gid:       '503'
          home:      '/home/fred'
          managehome: true

Defaults:

* ensure: present
* shell:  /bin/bash

## yumrepos

Managed yum repository files under /etc/yum.repos.d

Example configuration:

    system:
      yumrepos:
        'puppetlabs-deps':
          baseurl:  'http://yum.puppetlabs.com/fedora/f17/dependencies/$basearch'
          descr:    'Puppet Labs Dependencies Fedora 17 - $basearch'
          enabled:  '1'
          gpgcheck: '1'
          gpgkey:   'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'
        'puppetlabs-products':
          baseurl:  'http://yum.puppetlabs.com/fedora/f17/products/$basearch'
          descr:    'Puppet Labs Products Fedora 17 - $basearch'
          enabled:  '1'
          gpgcheck: '1'
          gpgkey:   'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'

Defaults:

* enabled: 1
* gpgcheck: 1

## providers

The augeasproviders module can be an alternate provider for the host, mailalias
and mounttab types.

Example configuration:

    system:
      providers:
        host: 'augeas'
        mailalias: 'augeas'
        mounttab: 'augeas'

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-system
