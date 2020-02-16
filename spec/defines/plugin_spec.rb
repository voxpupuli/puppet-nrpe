require 'spec_helper'

describe 'nrpe::plugin' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let(:title) { 'check_users' }
      let(:params) do
        {
          ensure: 'present',
          source: 'puppet:///modules/profile/nrpe/check_users'
        }
      end

      it { is_expected.to compile.with_all_deps }
      case facts[:osfamily]
      when 'Debian'
        it { is_expected.to contain_file('/usr/lib/nagios/plugins/check_users').that_requires('Package[nagios-nrpe-server]') }
      when 'Gentoo'
        it { is_expected.to contain_file('/usr/lib/nagios/plugins/check_users').that_requires('Package[net-analyzer/nrpe]') }
      else
        it { is_expected.to contain_file('/usr/lib64/nagios/plugins/check_users').that_requires('Package[nrpe]') }
      end
    end
  end
end
