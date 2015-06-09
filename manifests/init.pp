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
  package { 'puppetmaster':
    ensure => installed,
  }
  class { 'puppetdb':
    disable_ssl => true,
  }
  class { 'puppetdb::master::config':
#    strict_validation => false,
    puppetdb_server => 'localhost',
  }
#  class { 'puppet::master':
#    storeconfigs               => true,
#    passenger_high_performance => "on",
#  }
}
