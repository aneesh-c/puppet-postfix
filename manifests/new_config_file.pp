define postfix::new_config_file (
  $package_name             = [ 'postfix' ],
  $configdir_newconfigfile  = '/etc/postfix',
  $configfile_newconfigfile = undef,
  $template_newconfigfile   = 'postfix/new_config_file.erb',
  $user                     = undef,
  $password                 = undef,
  $dbname                   = undef,
  $query                    = undef,
  $hosts                    = undef,
) {
  file { "${configdir_newconfigfile}/${configfile_newconfigfile}":
    require => package[$package_name],
    content => template($template_newconfigfile),
    group   => 'postfix',
    mode    => '0640',
  }
}
