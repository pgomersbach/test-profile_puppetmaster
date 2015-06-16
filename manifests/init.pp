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

  host { $::fqdn:
    ip           => $::ipaddress,
    host_aliases => 'puppet',
  }

  apt::source { 'puppetlabs':
    location => 'http://apt.puppetlabs.com',
#    key      => {
#      id     => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
#      server => 'pgp.mit.edu',
#    },
  }

  package { 'puppetmaster-passenger':
    ensure  => installed,
    require => Apt::Source['puppetlabs'],
  }

  class { 'puppetdb':
    listen_address => '0.0.0.0',
    require        => [ Apt::Source['puppetlabs'], Host[ $::fqdn ] ],
  }

  class { 'puppetdb::master::config':
    puppetdb_soft_write_failure => true,
    puppet_service_name         => 'apache2',
    strict_validation           => false,
    puppetdb_startup_timeout    => '300',
    terminus_package            => 'puppetdb-terminus',
    require                     => Apt::Source['puppetlabs'],
  }
}
