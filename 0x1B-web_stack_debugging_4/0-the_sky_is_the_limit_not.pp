# Fixes the issue of faild requests due to high amount of traffic

#Increases the ULIMIT of the default file
exec { 'fixing-nginx':
  #Modify the ULIMIT value
  command => '/bin/sed -i "s/15/4096/" /etc/default/nginx',
  # Speecify the path for the sed command
  path    => '/usr/local/bin/:/bin/',
}

#restart Nginx server
exec { 'nginx-restart':
  #Restart nginx services
  command => '/etc/init.d/nginx restart',
  # Specify the path for the init.d script
  path    => '/etc/init.d/',
}
