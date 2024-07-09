#Install Nginx web server (w/ Puppet)

package { 'nginx':
  ensure => 'installed',
}

file_line { 'install':
  ensure => 'present',
  path   => '/etc/nginx/site-enabled/default',
  after  => 'listen 80 default_server;',
  line   => 'rewite ^/redirect_me https://www.github.com/bossambani permanent;',
}

file { '/var/www/html/index.html':
  content => 'Hello World!',
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
