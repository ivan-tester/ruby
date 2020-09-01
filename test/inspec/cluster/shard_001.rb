# frozen_string_literal: true

control 'shard-001-primary-is-running' do
  impact 1.0
  title 'MongoDB Shard 001 primary should be running'

  describe service('mongodb-sh-001-primary') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(33018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-001-secondary-is-running' do
  impact 1.0
  title 'MongoDB Shard 001 secondary should be running'

  describe service('mongodb-sh-001-secondary') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(34018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-001-arbiter-is-running' do
  impact 1.0
  title 'MongoDB Shard 001 arbiter should be running'

  describe service('mongodb-sh-001-arbiter') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(35018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-001-hidden-is-running' do
  impact 1.0
  title 'MongoDB Shard 001 hidden should be running'

  describe service('mongodb-sh-001-hidden') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(36018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-001-delayed-is-running' do
  impact 1.0
  title 'MongoDB Shard 001 delayed should be running'

  describe service('mongodb-sh-001-delayed') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(37018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end
