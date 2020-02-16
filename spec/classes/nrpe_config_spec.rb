require 'spec_helper'

describe 'nrpe::config' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'by default' do
        let(:pre_condition) { 'include nrpe' }

        it { is_expected.to contain_concat('/etc/nagios/nrpe.cfg') }
        it { is_expected.to contain_concat__fragment('nrpe main config') }
        it { is_expected.to contain_concat__fragment('nrpe includedir') }
        it { is_expected.to contain_file('nrpe_include_dir').with_ensure('directory') }
      end

      context 'when ssl is being used' do
        let(:pre_condition) do
          'class {\'nrpe\':
            ssl_cert_file_content       => \'cert file content\',
            ssl_privatekey_file_content => \'key file content\',
            ssl_cacert_file_content     => \'ca cert file content\',
           }'
        end

        it { is_expected.to contain_class('nrpe::config::ssl') }
      end

      context 'when supplementary_groups set' do
        let(:pre_condition) do
          'class {\'nrpe\':
            supplementary_groups => [\'foo\',\'bar\'],
           }'
        end

        case facts[:osfamily]
        when 'Debian','Gentoo'
          it { is_expected.to contain_user('nagios').with_groups(%w[foo bar]) }
        else
          it { is_expected.to contain_user('nrpe').with_groups(%w[foo bar]) }
        end
      end
    end
  end
end
