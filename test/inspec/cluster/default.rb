# frozen_string_literal: true

control 'default-mongod-disabled' do
  impact 1.0
  title 'Default mongo daemon should be disabled and stopped'

  describe processes('/usr/bin/mongod --quiet --config /etc/mongod.conf') do
    it { should_not exist }
  end

  describe service('mongod') do
    it { should_not be_enabled }
    it { should_not be_running }
  end
end
