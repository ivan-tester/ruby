# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbReplicaset < Chef::Resource
    resource_name :mongodb_replicaset

    property :config, Hash, coerce: proc { |c| coerce_mongodb_replicaset_config(c) }, required: true
    property :config_cache_path, String, default: lazy { default_config_cache_path }, desired_state: false

    default_action :configure
    allowed_actions :configure

    def default_config_cache_path
      ::File.join(Chef::Config[:file_cache_path], "replicaset-config-#{name}.json")
    end

    include MongoDBLibHelpers::MongodbCluster
    include MongoDBLibHelpers::MongodbReplicaset

    # Include recipe helpers so we can use some functions inside the resource
    # Example:
    # mongodb_replicaset 'rs01' do
    #   config('members' => search_mongodb_replicaset_members(env, 'rs01'))
    # end
    include MongoDBLibHelpers::MongodbRecipeDSL

    #####################
    # Load Current Value
    #####################

    load_current_value do |desired|
      current_config = replicaset_config(desired.config)
      current_value_does_not_exist! unless current_config

      unless ::File.exist?(desired.config_cache_path)
        config current_config
        return
      end

      cached_config = load_replicaset_config(desired.config_cache_path)

      if current_config['version'] == cached_config['version']
        cached_config.delete('version')
        config cached_config
      else
        config current_config
      end
    end

    action_class do
      include MongoDBLibHelpers::MongodbCluster
      include MongoDBLibHelpers::MongodbReplicaset
    end

    action :configure do
      converge_if_changed do
        result = current_resource ? reconfigure_replicaset(new_resource.config) : configure_replicaset(new_resource.config)

        # If no result something went wrong, don't cache anything. Probably try again later.
        return unless result

        if result.ok?
          updated_config = replicaset_config(new_resource.config)
          new_resource.config['version'] = updated_config['version'] if updated_config
          save_replicaset_config(new_resource.config_cache_path, new_resource.config)
        end
      end
    end
  end
end
