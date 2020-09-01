# frozen_string_literal: true

control 'config-primary-is-running' do
  impact 1.0
  title 'MongoDB Primary Config should be running'

  describe service('mongodb-config-primary') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(27019) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end

  describe file('/var/lib/mongodb-config-primary') do
    it { should be_directory }
  end

  describe file('/var/log/mongodb') do
    it { should be_directory }
  end
end

control 'config-secondary-is-running' do
  impact 1.0
  title 'MongoDB Secondary Config should be running'

  describe service('mongodb-config-secondary') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(29019) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end
