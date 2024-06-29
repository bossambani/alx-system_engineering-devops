#Using Puppet, install flask from pip3
package {'python3-pip':
  ensure  => 'installed',
}

exec { '1-install_a_package':
  command => '/usr/bin/pip3 install flask==2.1.0',
  unless  => '/usr/bin/pip3 show flask | grep "Version: 2.1.0"',
  require => Package['python3-pip'],
}
