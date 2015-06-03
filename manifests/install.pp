# == Class profile_puppetmaster::install
#
# This class is called from profile_puppetmaster for install.
#
class profile_puppetmaster::install {

  package { $::profile_puppetmaster::package_name:
    ensure => present,
  }
}
