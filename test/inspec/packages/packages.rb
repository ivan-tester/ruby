# frozen_string_literal: true

version = attribute('mongodb_package_version', default: '3.4.10', description: 'version to install')

control "all-mongodb-#{version}-packages-installed" do
  impact 1.0
  title "Make sure all required packages have been installed with #{version}"

  %w(mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools).each do |pkg|
    describe package(pkg) do
      it { should be_installed }
      its('version') { should match(/#{version}/) }
    end
  end
end
