# == Class profile_puppetmaster::service
#
# This class is meant to be called from profile_puppetmaster.
# It ensure the service is running.
#
class profile_puppetmaster::service {

  service { $::profile_puppetmaster::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
