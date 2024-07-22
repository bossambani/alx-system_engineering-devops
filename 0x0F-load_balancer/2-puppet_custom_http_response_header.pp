#configures a brand new Ubuntu machine and add custom HTTP header

exec { 'update system':
  command   => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure    => 'installed',
  require   => Exec['update system'],
}

file {'/var/www/html/index.html':
  content   => 'Hello World!',
}

exec {'redirect_me':
  command   => 'sed -i "/server {/a\\\t\trewrite ^/redirect_me https://github.com/bossambani/ permanent;" /etc/nginx/sites-available/default';
  provider  => 'shell',
  require   => Package['nginx'],
}

exec {'HTTP header':
  command   => 'sed -i "/server {/a\\\t\tadd_header X-Served-By \$hostname;" /etc/nginx/sites-available/default';
  provider  => 'shell',
  require   => Exec['redirect_me'],
}

service {'nginx':
  ensure    => running,
  require   => Package['nginx'],
  subscribe => Exec['redirect_me', 'HTTP header'],
}
