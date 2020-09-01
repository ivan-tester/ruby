# frozen_string_literal: true

control 'router-1-is-running' do
  impact 1.0
  title 'MongoDB Router should be running'

  describe service('router-1') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(27017) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end

control 'router-2-is-running' do
  impact 1.0
  title 'MongoDB Router should be running'

  describe service('router-2') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(28017) do
    it { should be_listening }
    its('addresses') { should include '0.0.0.0' }
  end
end
