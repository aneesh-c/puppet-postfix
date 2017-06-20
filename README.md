# POSTFIX Module

## Overview
This module install and configure postfix smtp server.

## Usage

Default configuration:

```puppet
include postfix
```

Change configuration file settings:

```puppet
class { 'postfix':
    myhostname                          => 'mail.example.com',
    mydomain                            => 'example.com',
    mynetworks                          => '192.168.1.0/24, 127.0.0.0/8',
    mydestination                       => '$myhostname, localhost, localhost.localdomain',
    message_size_limit                  => '30720000',
    virtual_alias_domains               => '',
    virtual_alias_maps                  => 'proxy:mysql:/etc/postfix/mysql-virtual_forwardings.cf, mysql:/etc/postfix/mysql-virtual_email2email.cf',
    virtual_mailbox_domains             => 'proxy:mysql:/etc/postfix/mysql-virtual_domains.cf',
    virtual_mailbox_maps                => 'proxy:mysql:/etc/postfix/mysql-virtual_mailboxes.cf',
    virtual_mailbox_base                => '/home/vmail',
    virtual_uid_maps                    => 'static:5000',
    virtual_gid_maps                    => 'static:5000',
    smtpd_sasl_type                     => 'dovecot',
    smtpd_sasl_path                     => 'private/auth',
    smtpd_sasl_auth_enable              => 'yes',
    broken_sasl_auth_clients            => 'yes',
    smtpd_sasl_authenticated_header     => 'yes',
    smtpd_recipient_restrictions        => 'permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination',
    smtpd_use_tls                       => 'yes',
    smtpd_tls_cert_file                 => '</etc/pki/dovecot/certs/dovecot.pem',
    smtpd_tls_key_file                  => '</etc/pki/dovecot/private/dovecot.pem',
    virtual_create_maildirsize          => 'yes',
    virtual_maildir_extended            => 'yes',
    proxy_read_maps                     => '$local_recipient_maps $mydestination $virtual_alias_maps $virtual_alias_domains $virtual_mailbox_maps $virtual_mailbox_domains $relay_recipient_maps $relay_domains $canonical_maps $sender_canonical_maps $recipient_canonical_maps $relocated_maps $transport_maps $mynetworks $virtual_mailbox_limit_maps',
    virtual_transport                   => 'dovecot',
    dovecot_destination_recipient_limit => '1',
}
```

Query file settings:

```puppet
postfix::new_config_file { 'mysql-virtual_domains.cf':
    configfile_newconfigfile => 'mysql-virtual_domains.cf',
    user                     => 'mail_admin',
    password                 => 'password',
    dbname                   => 'emaildb',
    query                    => 'SELECT domain AS virtual FROM domaintb WHERE domain="%s"',
    hosts                    => '127.0.0.1',
}
```
