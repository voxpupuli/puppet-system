# puppet-system

Manage Linux system resources and services from hiera configuration.

* *augeas*: apply file changes using the augeas tool
* *crontabs*: set user crontab entries
* *execs*:  run idempotent external commands
* *facts*: set custom facts
* *files*: create/update files or directories
* *groups*: manage entries in /etc/group
* *hosts*: manage entries in /etc/hosts
* *limits*: manage entries in /etc/security/limits.conf
* *mail* manage entries in /etc/aliases or set a relay host
* *mounts*: manage entries in /etc/fstab
* *network*: configure basic networking and dns
* *ntp*: configure NTP servers in /etc/ntp.conf
* *packages*: manage system packages
* *schedules*: determine when resource config should not be applied and how often
* *services*: manage system services
* *sshd*: manage configuration in /etc/ssh/sshd_config including subsystems like sftp
* *sysconfig*: manage files under /etc/sysconfig: clock, i18n, keyboard, puppet-dashboard, puppet, puppetmaster, selinux
* *sysctl*: manage entries in /etc/sysctl.conf
* *templates*: create files from ERB templates
* *users*: manage users in /etc/passwd and /etc/shadow
* *yumgroups*: manage system package groups
* *yumrepos*: manage yum repository files under /etc/yum.repos.d

## Documentation

For default types (users, groups, mounts, yumrepos, packages, cron, exec) see
the documentation at http://docs.puppetlabs.com/references/latest/type.html for
the parameters that can be passed to each of the resources.

For augeasproviders types (sysctl, sshd) see
http://forge.puppetlabs.com/domcleal/augeasproviders.

For limits see http://forge.puppetlabs.com/erwbgy/limits.

## Usage

Include the system module in your puppet configuration:

    include system

and add required hiera configuration.

Note: To exclude certain system classes when doing 'include system' you can set
their schedule parameter to 'never'.  This may be useful when testing or
debugging issues or just to prevent config lower in the hierarchy being
applied.

For example:

    system::packages::schedule:  'never'
    system::yumgroups::schedule: 'never'

will ignore any configuration for system::packages and system::yumgroups.

## augeas

Apply changes to files using the augeas tool.  This enables simple
configuration file changes to be made without writing new classes.

Example 1:

    system::augeas:
      'ntp':
        context: '/files/etc/ntp.conf'
        changes:
          - 'set server[1] 0.uk.pool.ntp.org'
          - 'set server[2] 1.uk.pool.ntp.org'
          - 'set server[3] 2.uk.pool.ntp.org'

Example 2:

    system::augeas:
      'test1':
        context: '/files/etc/sysconfig/firstboot'
        changes:
          - 'set RUN_FIRSTBOOT YES'
        onlyif:  'match other_value size > 0'

Example 3:

    system::augeas:
      'jboss_conf':
        context: '/files'
        changes:
          - 'set etc/jbossas/jbossas.conf/JBOSS_IP $ipaddress'
          - 'set etc/jbossas/jbossas.conf/JAVA_HOME /usr'
        load_path: '/usr/share/jbossas/lenses'

Defaults:

* ensure: present
* user: root

## crontabs

Set user crontab entries

Example configuration:

    system::crontabs:
      'root-logrotate':
        command: '/usr/sbin/logrotate'
        user:    'root'
        hour:    '2'
        minute:  '0'

Defaults:

* ensure: present
* user: root

## execs

Run idempotent external commands

Example configuration:

    system::execs:
      '/bin/mkdir -p /apps/tomcat1/deploy':
        unless:  '/usr/bin/test -d /apps/tomcat1/deploy'
      "/usr/bin/perl -pi -e 's: grep 1.6: egrep \"1.6/1.7\":' /apps/wso2esb1/product/wso2esb/bin/wso2server.sh":
        onlyif: '/bin/grep -w "grep 1.6" /apps/wso2esb1/product/wso2esb/bin/wso2server.sh'

Note: The commands will be run on every Puppet run unless you specify 'onlyif',
'unless' or 'refreshonly' parameters.

## facts

Set custom facts using the facter_dot_d Facter plugin that loads facts from
/etc/facter/facts.d
(https://github.com/ripienaar/facter-facts/tree/master/facts-dot-d)

Example configuration:

    system::facts:
      location:
        value: 'London'
      ntpq:
        type:  'script'
        value: "#!/bin/bash\nprintf ntpq=\n/usr/sbin/ntpq -p | /usr/bin/tail -1\n"

These facts can be queried on a host using 'facter -p':

    $ facter -p location
    London
    $ facter -p ntpq
    *10.43.4.8       158.43.128.33    2 u  820 1024  377    0.538    0.155   0.048

Set:

    system::facts::cleanold: true

to remove facts from the old locations under /etc/profile.d and in
/etc/sysconfig/puppet.

## files

Create or update files or directories

Example 1 - create a mount point for an NFS mounted directory:

    system::files:
      /apps:
        ensure:  'directory'
        owner:   'root'
        group:   'root'
        mode:    '0755'

Example 2 - create a file with the given content:

    system::files:
      /etc/motd:
        ensure:  'present'
        owner:   'root'
        group:   'root'
        mode:    '0644'
        content: "Authorised access only\nIf unauthorised log off now or face prosecution\n"

Note: Use double-quotes if your content contains embedded newlines (\n) or tabs
(\t).  Normally you will also want a terminating newline.

## groups

Manage entries in /etc/group

Example configuration:

    system::groups:
      'sysadmins':
        ensure: 'present'
        gid:    '1500'
      'ops':
        gid:    '1503'
    system::groups::realize:
      - 'keith'
 
Defaults:

* ensure: present

By default virtual group resources are created that must then be realized.  To
create real resources instead (as with earlier versions of this module) use:

    system::groups::real: 'true'

## hosts

Manage entries in /etc/hosts

Example configuration:

    system::hosts:
      puppet:
        ensure:       'present'
        ip:           '10.5.11.19'
        host_aliases: [ 'puppet.local' ]

Defaults:
* ensure: present

See: http://docs.puppetlabs.com/references/latest/type.html#host

## limits

Manage entries in /etc/security/limits.conf

Example configuration:

    system::limits:
      '*':
        nofile:
          soft: 1024
          hard: 2048
      '@weblogic':
        nofile:
          soft: 16384
          hard: 16384
        nproc:
          soft: 2048
          hard: 2048

No defaults.

## mail

Manage entries in /etc/aliases or set a relay host

Example configuration:

    system::mail:
      aliases:
        postmaster:
          recipient: 'root'
        webmaster:
          recipient: 'fred@domain.com'
      relayhost:     'mail.domain.com'
      type:          'postfix'

No defaults.

See: http://docs.puppetlabs.com/references/latest/type.html#mailalias

Currently only 'postfix' is supported for setting a relay host.

## mounts

Manage entries in /etc/fstab

Example configuration:

    system::mounts:
      '/home':
        ensure:  'mounted'
        device:  '/dev/mapper/vg_x120-lv_home'
        atboot:  'true'
        fstype:  'ext4'
        options: 'defaults'

Defaults:

* atboot: true
* ensure: mounted

Note: These resources are created last so any required users, groups or mount
point directories have a chance to be created first.

## network

Configure basic networking: set hostname, enable/disable zeroconf/IPv6, set the default route,
configure interfaces and their static routes, configure nameserver resolvers and domains

Example configuration:

    system::network::hostname: 'puppet.domain.com'
    system::network::gateway:  '10.7.0.1'
    system::network::ipv6:     'false'
    system::network::zeroconf: 'false'
    system::network::dns:
      nameservers: [ '10.7.96.2', '10.7.96.2' ]
      domains:     [ 'domain.com', 'sub.domain.com' ]
    system::network::interfaces:
      eth0:
        ipaddress: '10.7.96.21'
        netmask:   '255.255.240.0'
        routes:
          '10.0.0.0/8':
            via: '10.16.0.250'

## ntp

Manage NTP servers in /etc/ntp.conf

Example 1:

    system::ntp::iburst:  'true'
    system::ntp::servers: [ 'ntp1.example.com' ]

Example 2:

    system::ntp::iburst:  'true'
    system::ntp::country: 'uk'

See https://github.com/erwbgy/puppet-ntp for more details

Note: The NTP algorithm does not work properly with two NTP servers.

## packages

Manage system packages

Example configuration:

    system::packages:
      AdobeReader_enu:
        ensure: '9.5.1-1'
      ConsoleKit:
        ensure: '0.4.5-2.fc17'

Defaults:

* ensure: installed

## schedules

Create schedules that determine when a resource should not be applied and the
number times it should be applied within a specified time period.

Example configuration:

    system::schedules:
      'maintenance':
        range:  '2 - 4'
        period: 'daily'
        repeat: 1
      'half-hourly':
        period: 'hourly'
        repeat: 2

The defined schedules can then be passed using the 'schedule' parameter to
other types.

Example 1:

    system::schedule: 'maintenance'

sets the default schedule for all system resources so that they are only
run during the maintenance window of 2:00 to 04:59.

Example 2:

    system::services::schedule: 'daily'

sets the default schedule for all system::services resources to be once a day.

Example 3:

    system::services:
      httpd:
        ensure: 'running'
        enable: 'true'
        schedule: 'half-hourly'

overrides the services schedule for the httpd resource using a custom schedule
we defined above.

The default Puppet schedules are:

* daily
* hourly
* monthly
* never
* weekly

and the system::schedule class defines another called *always* that schedules
the resource on every Puppet run.

## selbooleans

Manages SELinux booleans

Example configuration:

    system::selbooleans:
      'httpd_can_network_connect':
        value: 'on'
        persistent: 'true'

Defaults:

* persistent: false

## services

Manage system services

Example configuration:

    system::services:
      cups:
        ensure: 'stopped'
        enable: 'false'
      sshd:
        ensure: 'running'
        enable: 'true'
      ntpd:
        ensure: 'running'
        enable: 'true'

Defaults:

* ensure: running

Note:

* Do not specify any services that are managed by other Puppet modules (eg.
  ntpd or network) otherwise you may get conflicts

## sshd

Manage settings in /etc/ssh/sshd.conf

Synchronize host keys file entries across all puppet-managed hosts.

Example configuration:

    system::sshd:
      AllowGroups:
        value:     [ 'sshusers', 'admin' ]
      PermitRootLogin:
        value:     'without-password'
        condition: 'Host example.net'

    system::sshd::subsystem:
      sftp:
        command: '/usr/libexec/openssh/sftp-server -u 0002'

    system::sshd::sync_host_keys: 'true'

No defaults.

See:

* https://github.com/domcleal/augeasproviders/blob/master/lib/puppet/type/sshd_config.rb
* https://github.com/domcleal/augeasproviders/blob/master/lib/puppet/type/sshd_config_subsystem.rb

## sysconfig

Manage settings in files under /etc/sysconfig

Example configuration:

    system::sysconfig::clock:
      timezone: 'Europe/London'

    system::sysconfig::i18n:
      # Run 'locale -a' to see possible lang values
      lang: 'en_GB.utf8'

    system::sysconfig::keyboard:
      keytable:     'uk'
      model:        'pc105'
      layout:       'gb'
      keyboardtype: 'pc'

    system::sysconfig::puppet:
      server: 'puppet.sbet'

    system::sysconfig::selinux:
      state: 'enforcing'

No defaults.

Note: Values must not contain whitespace

## sysctl

Manage settings in /etc/sysctl.conf

Example configuration:

    system::sysctl:
      kernel.msgmnb:
        value: '131072'
        comment: 'Controls the default maximum size of a message queue'
      kernel.msgmax:
        value: '131072'
        comment: ' Controls the maximum size of a message, in bytes'

No defaults.

See:

* https://github.com/domcleal/augeasproviders/blob/master/lib/puppet/type/sysctl.rb


Note: Quote numeric values to avoid "can't convert Fixnum into String" errors

## templates

Create files from ERB templates

Example configuration:

    system::templates:
      /etc/motd:
        owner:    'root'
        group:    'root'
        mode:     '0644'
        template: "/var/lib/puppet/templates/motd-%{osfamily}.erb"
      /etc/environment:
        owner:    'root'
        group:    'root'
        mode:     '0644'
        template: "environment.erb"

Default:

* owner: root
* group: root

If **template** is a relative path then Puppet will look for template file in
*template_dir* (eg. /var/lib/puppet/templates).

Templates can use any facts set for the destination host.

## users

Manage users entries in /etc/passwd and /etc/shadow

Example configuration:

    system::users:
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
    system::users::realize:
      - 'keith'

Defaults:

* ensure: present
* shell:  /bin/bash

By default virtual user resources are created that must then be realized.  To
create real resources instead (as with earlier versions of this module) use:

    system::users::real: 'true'

## yumgroups

Manage system package groups

Example configuration:

    system::yumgroups:
      'Base':
        ensure: 'present'
      'Console internet tools':
        ensure: 'present'
      'Perl Support':
        ensure: 'present'
        usecache: false
      'Ruby Support':
        ensure: 'present'
        optional: true
        usecache: false

Defaults:

* optional: false
* usecache: true
* schedule: daily

Note: Set 'usecache: false' if 'yum -C grouplist' does not work on your system
and you are getting System::Yumgroup resources created on every Puppet run

Note: By default the yumgroup type has a 'daily' schedule to reduce the time
Puppet runs take - package group changes are usually rare after the host is
first set up. This means that it will run once every 24 hours. You override
this by supplying your own schedule parameter - see system::schedules to create
your own custom schedules.

## yumrepos

Manage yum repository files under /etc/yum.repos.d

Example configuration:

    system::yumrepos:
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

    system::providers:
      host: 'augeas'
      mailalias: 'augeas'
      mounttab: 'augeas'

## Notes

* Do not specify resources that are managed by other Puppet modules otherwise
  you will get conflict errors.

* As with many default types you can often specify a 'target' parameter to
  specify a different configuration filename to change.

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-system
