require 'spec_helper'

describe 'profile_puppetmaster' do
  context 'supported operating systems' do

    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end
        context "profile_puppetmaster class without any parameters" do
          let(:params) {{ }}
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_puppetmaster') }
          it { is_expected.to contain_host( facts[:fqdn] )}
          it { is_expected.to contain_apt__source('puppetlabs') }
          it { is_expected.to contain_package('puppetmaster-passenger').that_requires('Apt::source[puppetlabs]') }
          it { is_expected.to contain_class('puppetdb').that_requires('Apt::source[puppetlabs]') }
          it { is_expected.to contain_class('puppetdb::master::config').that_requires('Class[puppetdb]') }
         
        end
      end
    end
  end
end
