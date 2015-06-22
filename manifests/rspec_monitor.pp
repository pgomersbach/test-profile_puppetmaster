# == Class profile_puppetmaster::install
#
# This class is called from profile_puppetmaster for install.
#
class profile_puppetmaster::rspec_monitor {
  include ::rspec_monitor

  rspec_monitor::add_tests { $module_name: }

}
