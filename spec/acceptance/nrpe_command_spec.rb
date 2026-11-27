# frozen_string_literal: true

require 'spec_helper_acceptance'

case fact('osfamily')
when 'Debian'
  nrpe_plugin_package = 'nagios-nrpe-plugin'
  nrpe_plugindir      = '/usr/lib/nagios/plugins'
  nrpe_includedir     = '/etc/nagios/nrpe.d'
when 'FreeBSD'
  nrpe_plugin_package = 'nagios-plugins'
  nrpe_plugindir      = '/usr/local/libexec/nagios'
  nrpe_includedir     = '/usr/local/etc/nrpe.d'
else
  nrpe_plugin_package = 'nagios-plugins-nrpe'
  nrpe_plugindir      = '/usr/lib64/nagios/plugins'
  nrpe_includedir     = '/etc/nrpe.d'
end

describe 'nrpe::command class' do
  let(:nrpe_user) do
    case fact('osfamily')
    when 'RedHat' then 'nrpe'
    else 'nagios'
    end
  end

  let(:nrpe_group) { nrpe_user }

  describe 'Scenario: default_commands' do
    include_examples 'the example', 'default_commands.pp'
    describe 'the NRPE includedir' do
      describe file(nrpe_includedir) do
        it { is_expected.to be_a_directory }
      end

      describe command("ls #{nrpe_includedir}/*.cfg | wc -l") do
        its(:stdout) { is_expected.to match('5') }
      end
    end
  end

  describe 'Scenario: purge_commands' do
    include_examples 'the example', 'purge_commands.pp'

    describe command("ls #{nrpe_includedir}/*.cfg | wc -l") do
      its(:stdout) { is_expected.to match('1') }
    end
  end

  describe 'Scenario: command file ownership and mode' do
    let(:pp) do
      <<~MANIFEST
        nrpe::command { 'check_dummy':
          command   => 'check_dummy 0',
          owner     => '#{nrpe_user}',
          group     => '#{nrpe_group}',
          file_mode => '0640',
        }
      MANIFEST
    end

    include_examples 'an idempotent resource'

    describe file("#{nrpe_includedir}/check_dummy.cfg") do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by nrpe_user }
      it { is_expected.to be_grouped_into nrpe_group }
      it { is_expected.to be_mode 640 }
    end
  end

  describe 'Scenario: check_dummy' do
    before do
      apply_manifest("package { '#{nrpe_plugin_package}': ensure => present }", catch_failures: true)
    end

    include_examples 'the example', 'check_dummy.pp'

    describe command("#{nrpe_plugindir}/check_nrpe -H 127.0.0.1 -c check_dummy") do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match('OK') }
    end
  end
end
