class postfix::params {
  if $::osfamily == 'RedHat' {
    $package_name = [ 'postfix' ]
  }
  elsif $::osfamily == 'Debian' {
    $package_name = [ 'postfix', 'postfix-mysql' ]
  }
}
