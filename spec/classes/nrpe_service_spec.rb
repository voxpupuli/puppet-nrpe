require 'spec_helper'

describe 'nrpe::service' do
  on_supported_os(facterversion: '3.6').each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'by default' do
        let(:pre_condition) { 'include nrpe' }

        service_name = case facts[:osfamily]
                       when 'Debian'
                         'nagios-nrpe-server'
                       when 'FreeBSD'
                         'nrpe3'
                       else
                         'nrpe'
                       end
        it {
          is_expected.to contain_service(service_name).with(
            'ensure' => 'running',
            'enable' => true
          )
        }
      end
    end
  end
end
