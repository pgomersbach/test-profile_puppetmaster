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

  

        end
      end
    end
  end
end
