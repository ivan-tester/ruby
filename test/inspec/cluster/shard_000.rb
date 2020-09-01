# frozen_string_literal: true

control 'shard-000-primary-is-running' do
  impact 1.0
  title 'MongoDB Shard 000 primary should be running'

  describe service('mongodb-sh-000-primary') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(27018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-000-secondary-is-running' do
  impact 1.0
  title 'MongoDB Shard 000 secondary should be running'

  describe service('mongodb-sh-000-secondary') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(29018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-000-arbiter-is-running' do
  impact 1.0
  title 'MongoDB Shard 000 arbiter should be running'

  describe service('mongodb-sh-000-arbiter') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(30018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-000-hidden-is-running' do
  impact 1.0
  title 'MongoDB Shard 000 hidden should be running'

  describe service('mongodb-sh-000-hidden') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(31018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'shard-000-delayed-is-running' do
  impact 1.0
  title 'MongoDB Shard 000 delayed should be running'

  describe service('mongodb-sh-000-delayed') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(32018) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end
