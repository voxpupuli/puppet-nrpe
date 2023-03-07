require 'spec_helper'

describe 'nrpe::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'by default' do
        let(:pre_condition) { 'include nrpe' }

        case facts[:osfamily]
        when 'Debian'
          it { is_expected.to contain_package('nagios-nrpe-server').with_ensure('installed') }
          it { is_expected.to contain_package('monitoring-plugins').with_ensure('installed') }
        when 'Gentoo'
          it { is_expected.to contain_package('net-analyzer/nrpe').with_ensure('installed') }
          it { is_expected.to contain_package('net-analyzer/nagios-plugins').with_ensure('installed') }
        when 'FreeBSD'
          it { is_expected.to contain_package('nrpe3').with_ensure('installed') }
          it { is_expected.to contain_package('nagios-plugins').with_ensure('installed') }
        else
          it { is_expected.to contain_package('nrpe').with_ensure('installed') }
          it { is_expected.to contain_package('nagios-plugins-all').with_ensure('installed') }
        end
      end

      context 'when manage_package is false' do
        let(:pre_condition) { 'class {\'nrpe\': manage_package => false}' }

        it { is_expected.not_to contain_package('nrpe') }
      end
    end
  end
end
