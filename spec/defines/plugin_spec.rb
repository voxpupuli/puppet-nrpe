# frozen_string_literal: true

require 'spec_helper'

describe 'nrpe::plugin' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let(:title) { 'check_users' }
      let(:params) do
        {
          ensure: 'present',
          source: 'puppet:///modules/profile/nrpe/check_users',
        }
      end

      let(:platform) do
        case facts[:os]['family']
        when 'Debian'
          {
            file: '/usr/lib/nagios/plugins/check_users',
            package: 'nagios-nrpe-server',
            group: 'root',
          }
        when 'FreeBSD'
          {
            file: '/usr/local/libexec/nagios/check_users',
            package: 'nrpe',
            group: 'wheel',
          }
        when 'Gentoo'
          {
            file: '/usr/lib64/nagios/plugins/check_users',
            package: 'net-analyzer/nrpe',
            group: 'root',
          }
        else
          {
            file: '/usr/lib64/nagios/plugins/check_users',
            package: 'nrpe',
            group: 'root',
          }
        end
      end

      it { is_expected.to compile.with_all_deps }

      it do
        is_expected.to contain_file(platform[:file]).with(
          'owner' => 'root',
          'group' => platform[:group],
          'mode'  => '0755',
        ).that_requires("Package[#{platform[:package]}]")
      end

      context 'with a custom owner, group and mode' do
        let(:params) do
          super().merge(
            owner: 'nagios',
            group: 'nagios',
            file_mode: '0750',
          )
        end

        it do
          is_expected.to contain_file(platform[:file]).with(
            'owner' => 'nagios',
            'group' => 'nagios',
            'mode'  => '0750',
          )
        end
      end
    end
  end
end
