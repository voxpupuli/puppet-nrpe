require 'spec_helper'

describe 'nrpe::config::ssl' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'when ssl is being used' do
        let(:pre_condition) do
          'class {\'nrpe\':
            ssl_cert_file_content       => \'cert file content\',
            ssl_privatekey_file_content => \'key file content\',
            ssl_cacert_file_content     => \'ca cert file content\',
           }'
        end

        it { is_expected.to contain_concat__fragment('nrpe ssl fragment') }

        case facts[:osfamily]
          when 'FreeBSD'
            it { is_expected.to contain_file('/usr/local/etc/nrpe-ssl').with_ensure('directory') }
            it { is_expected.to contain_file('/usr/local/etc/nrpe-ssl/ca-cert.pem').with_ensure('file').with_content('ca cert file content') }
            it { is_expected.to contain_file('/usr/local/etc/nrpe-ssl/nrpe-cert.pem').with_ensure('file').with_content('cert file content') }
            it { is_expected.to contain_file('/usr/local/etc/nrpe-ssl/nrpe-key.pem').with_ensure('file').with_content('key file content') }
          else
            it { is_expected.to contain_file('/etc/nagios/nrpe-ssl').with_ensure('directory') }
            it { is_expected.to contain_file('/etc/nagios/nrpe-ssl/ca-cert.pem').with_ensure('file').with_content('ca cert file content') }
            it { is_expected.to contain_file('/etc/nagios/nrpe-ssl/nrpe-cert.pem').with_ensure('file').with_content('cert file content') }
            it { is_expected.to contain_file('/etc/nagios/nrpe-ssl/nrpe-key.pem').with_ensure('file').with_content('key file content') }
        end
      end
    end
  end
end
