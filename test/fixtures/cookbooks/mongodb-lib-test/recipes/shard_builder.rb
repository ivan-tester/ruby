# frozen_string_literal: true

%w[sh-000 sh-001].each do |sname|
  sh = search_mongodb_replicaset_members(node.chef_environment, sname)

  Chef::Log.warn("Received empty #{sname} hosts") if sh.empty?

  mongodb_shard sname do
    router 'dokken:27017'
    shard sh

    not_if { sh.empty? }
  end
end
