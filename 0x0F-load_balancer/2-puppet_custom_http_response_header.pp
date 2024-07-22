#configures a brand new Ubuntu machine and add custom HTTP header

exec {'update system':
	command  => '/usr/bin/apt-get update',
}

package {'nginx':
	ensure   => 'installed',
	require  => Exec['update system']
}

file {'/var/www/html/index.html':
	content  => 'Hello World!'
}

exec {'redirect_me':
	command  => 'sed -i "24:\	rewrite ^/redirect_me https://github.com/bossambani/ permanent;" /etc/nginx/sites-available/default;
	provider => 'shell'
}

exec {'HTTP header':
	command  => 'sed -i "25:\	add_header X-Served-By \$hostname;" /etc/nginx/sites-available/default;
	provider => 'shell'
}

service {'nginx':
	ensure   => running,
	require  => package['nginx']
}
