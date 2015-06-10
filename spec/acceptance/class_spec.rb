require 'spec_helper_acceptance'

describe 'profile_puppetmaster class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'profile_puppetmaster': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true, :future_parser => true)
      apply_manifest(pp, :catch_changes  => true, :future_parser => true)
    end
  
# a profile class should test if the included packages and services are installed, enabled and running. Please adept to your needs. See example below:
    describe host( host_inventory['fqdn'] ) do
      it { is_expected.to be_present }
    end

    describe package('postgresql-common') do
      it { is_expected.to be_installed }
    end

    describe service('postgresql') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(5432) do
      it { should be_listening.with('tcp') }
    end

    describe package('puppetmaster-passenger') do
      it { is_expected.to be_installed }
    end

    describe service('apache2') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

  end
end
