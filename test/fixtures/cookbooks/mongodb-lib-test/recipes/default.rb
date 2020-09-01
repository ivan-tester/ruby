# rubocop:disable all

include_recipe 'mongodb-lib::mongo_gem'

mongodb_repo node['mongodb']['lib']['version']

%w(mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools).each do |pkg|
  mongodb_package pkg do
    version node['mongodb']['lib']['version']
  end
end

# Disable packaged service
mongodb_service 'mongod' do
  action :stop
end

# Installing cluster
[
  # config
  'mongodb-config-primary',
  'mongodb-config-secondary',

  # Shard 000
  'mongodb-sh-000-primary',
  'mongodb-sh-000-secondary',
  'mongodb-sh-000-arbiter',
  'mongodb-sh-000-hidden',
  'mongodb-sh-000-delayed',

  # Shard 001
  'mongodb-sh-001-primary',
  'mongodb-sh-001-secondary',
  'mongodb-sh-001-arbiter',
  'mongodb-sh-001-hidden',
  'mongodb-sh-001-delayed'
].each do |instance|
  mongodb instance do
    config node['mongodb']['test'][instance]['config']
    replication node['mongodb']['test'][instance]['replication']

    notifies :restart, "mongodb_service[#{instance}]", :delayed
  end

  mongodb_service instance
end

[
  'router-1',
  'router-2'
].each do |instance|
  mongos instance do
    config node['mongodb']['test'][instance]['config']

    notifies :restart, "mongodb_service[#{instance}]", :delayed
  end

  mongodb_service instance do
    daemon_path '/usr/bin/mongos'
  end
end
# rubocop:enable all
