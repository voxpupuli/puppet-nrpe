# frozen_string_literal: true

require 'spec_helper'

describe 'nrpe::command' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      let(:title) { 'check_users' }
      let(:params) do
        {
          command: 'check_users -w 5 -c 10',
          ensure: 'present',
        }
      end

      let(:platform) do
        case facts[:os]['family']
        when 'Debian'
          {
            file: '/etc/nagios/nrpe.d/check_users.cfg',
            package: 'nagios-nrpe-server',
            group: 'root',
          }
        when 'Gentoo'
          {
            file: '/etc/nagios/nrpe.d/check_users.cfg',
            package: 'net-analyzer/nrpe',
            group: 'root',
          }
        when 'FreeBSD'
          {
            file: '/usr/local/etc/nrpe.d/check_users.cfg',
            package: 'nrpe',
            group: 'wheel',
          }
        else
          {
            file: '/etc/nrpe.d/check_users.cfg',
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
          'mode'  => '0644',
        ).that_requires("Package[#{platform[:package]}]")
      end

      context 'with a custom owner, group and mode' do
        let(:params) do
          super().merge(
            owner: 'nagios',
            group: 'nagios',
            file_mode: '0640',
          )
        end

        it do
          is_expected.to contain_file(platform[:file]).with(
            'owner' => 'nagios',
            'group' => 'nagios',
            'mode'  => '0640',
          )
        end
      end
    end
  end
end
