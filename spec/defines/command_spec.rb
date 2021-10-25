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
          ensure: 'present'
        }
      end

      it { is_expected.to compile.with_all_deps }
      case facts[:osfamily]
      when 'Debian'
        it {
          is_expected.to contain_file('/etc/nagios/nrpe.d/check_users.cfg').with(
            'mode' => '0644'
          ).that_requires(['Package[nagios-nrpe-server]'])
        }
      when 'Gentoo'
        it {
          is_expected.to contain_file('/etc/nagios/nrpe.d/check_users.cfg').with(
            'mode' => '0644'
          ).that_requires(['Package[net-analyzer/nrpe]'])
        }
      else
        it {
          is_expected.to contain_file('/etc/nrpe.d/check_users.cfg').with(
            'mode' => '0644'
          ).that_requires(['Package[nrpe]'])
        }
      end
    end
  end
end
