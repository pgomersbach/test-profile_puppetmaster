require 'spec_helper'

describe 'profile_puppetmaster' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "profile_puppetmaster class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_puppetmaster') }
          it { is_expected.to contain_apt__source('puppetlabs') }
          it { is_expected.to contain_class('puppetdb') }
          it { is_expected.to contain_package('puppetmaster-passenger') }
          it { is_expected.to contain_host( facts[:fqdn] )}
         
        end
      end
    end
  end
end
