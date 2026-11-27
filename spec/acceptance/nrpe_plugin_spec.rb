# frozen_string_literal: true

require 'spec_helper_acceptance'

nrpe_plugindir = case fact('osfamily')
                 when 'Debian' then '/usr/lib/nagios/plugins'
                 when 'FreeBSD' then '/usr/local/libexec/nagios'
                 else '/usr/lib64/nagios/plugins'
                 end

describe 'nrpe::plugin class' do
  let(:nrpe_user) do
    case fact('osfamily')
    when 'RedHat' then 'nrpe'
    else 'nagios'
    end
  end

  let(:nrpe_group) { nrpe_user }

  describe 'Scenario: plugin file ownership and mode' do
    let(:pp) do
      <<~MANIFEST
        nrpe::plugin { 'check_test':
          content   => '#!/bin/sh',
          owner     => '#{nrpe_user}',
          group     => '#{nrpe_group}',
          file_mode => '0750',
        }
      MANIFEST
    end

    it_behaves_like 'an idempotent resource'

    describe file("#{nrpe_plugindir}/check_test") do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by nrpe_user }
      it { is_expected.to be_grouped_into nrpe_group }
      it { is_expected.to be_mode 750 }
    end
  end
end
