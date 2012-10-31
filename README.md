# puppet-system

Manage users, groups, mounts, repositories and packages

A simple module to configure puppet's built-in user, group, mount, package and
yumrepo resources using hiera configuration.  See the documentation at:

  http://docs.puppetlabs.com/references/latest/type.html

for the parameters that can be passed to each of the resources.

## Usage

Include the system module in your puppet configuration:

    include system

and add required hiera configuration.

## users

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

## groups

Example configuration:

    system:
      groups:
        'keith':
          ensure: 'present'
          gid:    '500'
        'fred':
          gid:    '503'
    
## mount

Example configuration:

    system:
      mounts:
        '/home':
          ensure:  'mounted'
          device:  '/dev/mapper/vg_x120-lv_home'
          atboot:  'true'
          fstype:  'ext4'
          options: 'defaults'

## package

Example configuration:

    system:
      packages:
        AdobeReader_enu:
          ensure: '9.5.1-1'
        ConsoleKit:
          ensure: '0.4.5-2.fc17'

## yumrepos

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

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-system
