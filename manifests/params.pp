# == Class profile_puppetmaster::params
#
# This class is meant to be called from profile_puppetmaster.
# It sets variables according to platform.
#
class profile_puppetmaster::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'profile_puppetmaster'
      $service_name = 'profile_puppetmaster'
    }
    'RedHat', 'Amazon': {
      $package_name = 'profile_puppetmaster'
      $service_name = 'profile_puppetmaster'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
