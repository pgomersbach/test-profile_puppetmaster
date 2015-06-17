require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

if (defined?(hosts)).nil?
  puts "host not definedi, running production?"
else
  puts "host is defined, running in BEAKER?"
end

unless ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      install_puppet
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'profile_puppetmaster')
    hosts.each do |host|
      on host, shell('mkdir /tmp/modules')
      scp_to host, "#{proj_root}/spec/fixtures/modules/", "/tmp", {:ignore => ["profile_puppetmaster", ".bundle", ".git", ".idea", ".vagrant", ".vendor", "vendor", "acceptance", "bundle", "spec", "tests", "log", ".", ".."]}
      on host, shell('mv /tmp/modules/* /etc/puppet/modules')
    end
  end
end
