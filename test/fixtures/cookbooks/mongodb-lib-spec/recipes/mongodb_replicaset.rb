# frozen_string_literal: true

sh000 = search_mongodb_replicaset_members node.chef_environment, 'spec-sh-000'
sh001 = search_mongodb_replicaset_members node.chef_environment, 'spec-sh-001'

mongodb_replicaset 'spec-config' do # ~FC005
  config(
    '_id' => 'spec-config',
    'configsvr' => true,
    # inline method should also work
    'members' => search_mongodb_replicaset_members(node.chef_environment, 'spec-config')
  )
end

mongodb_replicaset 'spec-sh-000' do # ~FC005
  config(
    '_id' => 'spec-sh-000',
    'members' => sh000
  )
end

mongodb_replicaset 'spec-sh-001' do # ~FC005
  config(
    '_id' => 'spec-sh-001',
    'members' => sh001
  )
end
