# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbShard < Chef::Resource
    resource_name :mongodb_shard

    property :shard_name, String, name_property: true, required: true
    property :router, String, required: true, desired_state: false
    property :shard, [Array, String], required: true, desired_state: false
    property :max_size, Integer, default: 0, desired_state: false

    default_action :add
    allowed_actions :add

    include MongoDBLibHelpers::MongodbCluster
    include MongoDBLibHelpers::MongodbShard

    #####################
    # Load Current Value
    #####################

    load_current_value do |desired|
      shards = list_shards(desired.router)

      if shards.find { |s| s['_id'] == desired.shard_name }
        shard_name desired.shard_name
      else
        current_value_does_not_exist!
      end
    end

    action_class do
      include MongoDBLibHelpers::MongodbCluster
    end

    action :add do
      converge_if_changed do
        add_shard(new_resource.router, new_resource.shard_name, new_resource.shard, new_resource.max_size)
      end
    end
  end
end
