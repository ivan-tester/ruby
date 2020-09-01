require 'spec_helper'

describe 'mongodb-lib-spec::mongodb' do
  context 'on Debian (9)' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'debian',
        version: '9.0',
        step_into: 'mongodb'
      ).converge described_recipe
    end

    it_should_behave_like 'mongodb',
                          instance_name: 'single',
                          config_path: '/etc/single.conf',
                          db_directory: '/var/lib/single',
                          log_directory: '/var/log/mongodb',
                          actions: %w[create]

    it_should_behave_like 'mongodb',
                          instance_name: 'mongodb-primary',
                          config_path: '/etc/mongodb-primary.conf',
                          db_directory: '/var/lib/mongodb-primary',
                          log_directory: '/var/log/mongodb',
                          replication: { 'host' => 'fauxhai.local:27017' },
                          actions: %w[create]

    it_should_behave_like 'mongodb',
                          instance_name: 'mongodb-secondary',
                          config_path: '/etc/mongodb-secondary.conf',
                          db_directory: '/var/lib/mongodb-secondary',
                          log_directory: '/var/log/mongodb',
                          replication: { 'host' => 'fauxhai.local:27018', 'priority' => 0.5 },
                          actions: %w[create]

    it_should_behave_like 'mongodb',
                          instance_name: 'mongodb-delayed',
                          config_path: '/etc/mongodb-delayed.conf',
                          db_directory: '/var/lib/mongodb-delayed',
                          log_directory: '/var/log/mongodb',
                          replication: { 'host' => 'fauxhai.local:27017', 'priority' => 0, 'slaveDelay' => 3600 },
                          actions: %w[create]

  end
end
