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
        when 'Debian'
          it { is_expected.to contain_user('nagios').with_groups(%w[foo bar]) }
        else
          it { is_expected.to contain_user('nrpe').with_groups(%w[foo bar]) }
        end
      end

      describe 'allow_bash_command_substitution' do
        context 'by default' do
          let(:pre_condition) { 'include nrpe' }

          it { is_expected.not_to contain_concat__fragment('nrpe main config').with_content(%r{^allow_bash_command_substitution}) }
        end
        context 'when true' do
          let(:pre_condition) do
            <<-PRE_CONDITION
            class { 'nrpe':
              allow_bash_command_substitution => true,
            }
            PRE_CONDITION
          end

          it { is_expected.to contain_concat__fragment('nrpe main config').with_content(%r{^allow_bash_command_substitution=1$}) }
        end
        context 'when false' do
          let(:pre_condition) do
            <<-PRE_CONDITION
            class { 'nrpe':
              allow_bash_command_substitution => false,
            }
            PRE_CONDITION
          end

          it { is_expected.to contain_concat__fragment('nrpe main config').with_content(%r{^allow_bash_command_substitution=0$}) }
        end
      end
    end
  end
end
