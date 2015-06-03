require 'spec_helper_acceptance'

describe 'profile_puppetmaster class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'profile_puppetmaster': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end


  
# a profile class should test if the included packages and services are installed, enabled and running. Please adept to your needs. See example below:
   describe package('puppetmaster') do
      it { is_expected.to be_installed }
    end

    describe service('puppetmaster') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  

  end
end
