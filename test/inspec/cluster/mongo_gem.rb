# frozen_string_literal: true

control 'chef-gem-mongo' do
  impact 1.0
  title 'Mongo gem (>=2.4.0) should be installed into chef'

  describe command("/opt/chef/embedded/bin/gem list -v '>= 2.4.0' -i mongo") do
    its('exit_status') { should eq 0 }
  end
end
