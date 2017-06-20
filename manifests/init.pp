# == Class: postfix
#
# === Examples
#
#  class { 'postfix':
#    myhostname      => 'mail.example.com',
#    mydomain        => 'example.com',
#    mynetworks      => '192.168.1.0/24, 127.0.0.0/8',
#  }
#
# === Authors
#
# Aneesh C <aneeshchandrasekharan@gmail.com>
#

class postfix (
  $package_name                        = $::postfix::params::package_name,
  $template                            = 'postfix/configfile.erb',
  $queue_directory                     = undef,
  $command_directory                   = undef,
  $daemon_directory                    = undef,
  $data_directory                      = undef,
  $mail_owner                          = undef,
  $myhostname                          = undef,
  $mydomain                            = undef,
  $myorigin                            = undef,
  $inet_interfaces                     = undef,
  $inet_protocols                      = undef,
  $mydestination                       = undef,
  $unknown_local_recipient_reject_code = undef,
  $mynetworks                          = undef,
  $relayhost                           = undef,
  $alias_maps                          = undef,
  $alias_database                      = undef,
  $recipient_delimiter                 = undef,
  $home_mailbox                        = undef,
  $smtpd_banner                        = undef,
  $debug_peer_level                    = undef,
  $sendmail_path                       = undef,
  $newaliases_path                     = undef,
  $mailq_path                          = undef,
  $setgid_group                        = undef,
  $html_directory                      = undef,
  $manpage_directory                   = undef,
  $sample_directory                    = undef,
  $readme_directory                    = undef,
  $biff                                = undef,
  $append_dot_mydomain                 = undef,
  $smtpd_tls_cert_file                 = undef,
  $smtpd_tls_key_file                  = undef,
  $smtpd_use_tls                       = undef,
  $smtpd_tls_session_cache_database    = undef,
  $smtp_tls_session_cache_database     = undef,
  $mailbox_size_limit                  = undef,
  $smtpd_relay_restrictions            = undef,
  $message_size_limit                  = undef,
  $virtual_alias_domains               = undef,
  $virtual_alias_maps                  = undef,
  $virtual_mailbox_domains             = undef,
  $virtual_mailbox_maps                = undef,
  $virtual_mailbox_base                = undef,
  $virtual_uid_maps                    = undef,
  $virtual_gid_maps                    = undef,
  $smtpd_sasl_type                     = undef,
  $smtpd_sasl_path                     = undef,
  $smtpd_sasl_auth_enable              = undef,
  $broken_sasl_auth_clients            = undef,
  $smtpd_sasl_authenticated_header     = undef,
  $smtpd_recipient_restrictions        = undef,
  $virtual_create_maildirsize          = undef,
  $virtual_maildir_extended            = undef,
  $proxy_read_maps                     = undef,
  $virtual_transport                   = undef,
  $dovecot_destination_recipient_limit = undef,
) inherits postfix::params {
  package { $package_name: ensure => installed }
  file { '/etc/postfix/main.cf':
    require => package[$package_name],
    backup  => '.backup',
    content => template($template),
  }
  if $::osfamily == 'RedHat' {
    service { 'postfix':
      require => package[$package_name],
      enable  => true,
    }
  }
}
