class postfix::params {
  if $::osfamily == 'RedHat' {
    $package_name = [ 'postfix' ]
  }
  if $::osfamily == 'Debian' {
    $package_name = [ 'postfix', 'postfix-mysql' ]
  }
}
