#Using Puppet, create a manifest that kills a process named killmenow
exec {'kills_killmenow':
  command => '/usr/bin/pkill killmenow',
  onlyif  => '/usr/bin/pgrep killmenow',
}
