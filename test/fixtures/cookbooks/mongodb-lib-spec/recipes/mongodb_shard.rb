# frozen_string_literal: true

# You may find replica sets
# sh000 = search_mongodb_replicaset_members node.chef_environment, 'spec-sh-000'
# sh001 = search_mongodb_replicaset_members node.chef_environment, 'spec-sh-001'

mongodb_shard 'spec-sh-000' do
  router 'host:port'
  shard 'rs01/host1:port,host2:port'
  max_size 0
end

mongodb_shard 'spec-sh-001' do
  router 'host:port'
  shard 'rs02/host1:port,host2:port'
  # max_size 0 omitted
end
