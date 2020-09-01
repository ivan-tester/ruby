# rubocop:disable all

cfg = search_mongodb_replicaset_members(node.chef_environment, 'config')
sh000 = search_mongodb_replicaset_members(node.chef_environment, 'sh-000')
sh001 = search_mongodb_replicaset_members(node.chef_environment, 'sh-001')

Chef::Log.warn('Received empty config members') if cfg.empty?
Chef::Log.warn('Received empty sh-000 members') if sh000.empty?
Chef::Log.warn('Received empty sh-001 members') if sh001.empty?

mongodb_replicaset 'config' do # ~FC005
  config(
    '_id' => 'config',
    'configsvr' => true,
    'members' => cfg
  )
  config_cache_path '/tmp/config.json'

  not_if { cfg.empty? }
end

mongodb_replicaset 'sh-000' do
  config(
    '_id' => 'sh-000',
    'members' => sh000
  )
  config_cache_path '/tmp/sh-000.json'

  not_if { sh000.empty? }
end

mongodb_replicaset 'sh-001' do
  config(
    '_id' => 'sh-001',
    'members' => sh001
  )
  config_cache_path '/tmp/sh-001.json'

  not_if { sh001.empty? }
end

# rubocop:enable all
