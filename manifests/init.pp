# == Class: profile_puppetmaster
#
# Full description of class profile_puppetmaster here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_puppetmaster
{
  # a profile class includes one or more classes, please include below
  include apt
  include apt::update
  # update apt sources before installing packages
  Apt::Source <| |> -> Package <| |>

  host { $::fqdn:
    ip           => $::ipaddress,
    host_aliases => 'puppet',
  }

  apt::source { 'puppetlabs':
    location => 'http://apt.puppetlabs.com',
  }

  package { 'puppetmaster-passenger':
    ensure  => installed,
    require => Apt::Source['puppetlabs'],
  }

  class { 'puppetdb::globals':
#    version => '2.3.6-1puppetlabs1',
  }

  class { 'puppetdb':
    listen_address => '0.0.0.0',
    confdir        => '/etc/puppetdb/conf.d',
    require        => [ Apt::Source['puppetlabs'], Host[ $::fqdn ] ],
  }

  class { 'puppetdb::master::config':
    puppetdb_soft_write_failure => true,
    puppet_service_name         => 'apache2',
    strict_validation           => false,
    puppetdb_startup_timeout    => '300',
    manage_report_processor     => true,
    enable_reports              => true,
    terminus_package            => 'puppetdb-terminus',
    require                     => Class['puppetdb'],
  }

  exec { 'configure_ssl_from_puppet':
    command => '/usr/sbin/puppetdb ssl-setup',
    creates => '/etc/puppetdb/ssl/private.pem',
    require => Class['puppetdb'],
  }
}
