if ENV['BEAKER'] == 'true'
  # running in BEAKER test environment
  require 'spec_helper_acceptance'
else
  # running in production
  require 'serverspec'
  set :backend, :exec
end


describe 'profile_puppetmaster class' do

  context 'default parameters' do
    if ENV['BEAKER'] == 'true'
      # Using puppet_apply as a helper
      it 'should work idempotently with no errors' do
        pp = <<-EOS
        class { 'profile_puppetmaster': }
        EOS

        apply_manifest(pp, :catch_failures => true)
        sleep(10) # Puppetdb takes a while to start up
        apply_manifest(pp, :catch_failures => true)

      end
    end
  # a profile class should test if the included packages and services are installed, enabled and running. Please adept to your needs. See example below:

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

    describe package('puppetdb') do
      it { is_expected.to be_installed }
    end

    describe service('puppetdb') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8080) do
      it { should be_listening.with('tcp') }
    end

    describe package('puppetserver') do
      it { is_expected.to be_installed }
    end

    describe service('puppetserver') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8140) do
      it { should be_listening.with('tcp') }
    end

  end
end
