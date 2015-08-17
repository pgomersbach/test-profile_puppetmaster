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
  include java
  # update apt sources before installing packages
  Apt::Source <| |> -> Package <| |>

  host { $::fqdn:
    ip           => $::ipaddress,
    host_aliases => [ 'puppet', $::hostname ],
  }

  package { 'puppetserver':
    ensure => installed,
  }

  class { 'puppetdb':
    listen_address => '0.0.0.0',
  }

  class { 'puppetdb::master::config':
    puppetdb_soft_write_failure => true,
    strict_validation           => false,
    puppetdb_startup_timeout    => '300',
    manage_report_processor     => true,
    enable_reports              => true,
    terminus_package            => 'puppetdb-terminus',
    require                     => Class['puppetdb'],
  }

}
