require 'spec_helper'

describe 'mongodb-lib-spec::mongodb_service' do
  context 'on Centos (7)' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version: '7.3.1611',
        step_into: 'mongodb_service'
      ).converge described_recipe
    end

    it_should_behave_like 'mongodb service',
                          service_name: 'default-action',
                          daemon_path: '/usr/bin/mongod',
                          config_path: '/etc/default-action.conf',
                          implementation_class: 'MongoDBLibCookbook::MongodbServiceSystemd',
                          actions: %w[start]

    it_should_behave_like 'mongodb service',
                          service_name: 'start',
                          daemon_path: '/usr/bin/mongod',
                          config_path: '/etc/start.conf',
                          implementation_class: 'MongoDBLibCookbook::MongodbServiceSystemd',
                          actions: %w[start]

    it_should_behave_like 'mongodb service',
                          service_name: 'stop',
                          daemon_path: '/usr/bin/mongod',
                          config_path: '/etc/stop.conf',
                          implementation_class: 'MongoDBLibCookbook::MongodbServiceSystemd',
                          actions: %w[stop]

    it_should_behave_like 'mongodb service',
                          service_name: 'config-provided',
                          daemon_path: '/usr/bin/mongod',
                          config_path: '/mongodb.conf',
                          implementation_class: 'MongoDBLibCookbook::MongodbServiceSystemd',
                          actions: %w[stop start]

    it_should_behave_like 'mongodb service',
                          service_name: 'router',
                          daemon_path: '/usr/bin/mongos',
                          config_path: '/etc/router.conf',
                          implementation_class: 'MongoDBLibCookbook::MongodbServiceSystemd',
                          actions: %w[restart]
  end
end
