# frozen_string_literal: true

require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  install_package(host, 'epel-release') if fact_on(host, 'os.name') == 'CentOS'
  if fact_on(host, 'os.name') == 'OracleLinux'
    ver = fact_on(host, 'os.release.major')
    install_package(host, "oracle-epel-release-el#{ver}")
    on host, "yum-config-manager --enable ol#{ver}_optional_latest"
  end
end

shared_examples 'an idempotent resource' do
  it 'applies with no errors' do
    apply_manifest(pp, catch_failures: true)
  end

  it 'applies a second time without changes' do
    apply_manifest(pp, catch_changes: true)
  end
end

shared_examples 'the example' do |name|
  let(:pp) do
    path = File.join(File.dirname(__dir__), 'examples', name)
    File.read(path)
  end

  include_examples 'an idempotent resource'
end
