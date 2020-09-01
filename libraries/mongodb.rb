# frozen_string_literal: true

require_relative 'mongodb_base'

module MongoDBLibCookbook
  # This resource manages mongodb installation itself:
  # * generates config from hash
  # * creates data folder and log directories
  # * keeps replication settings
  # Actions:
  # @param create creates instance
  class Mongodb < MongodbBase
    resource_name :mongodb

    provides :mongodb, os: 'linux'

    property :config, Hash, coerce: proc { |c| coerce_mongodb_config(c) }, default: {}, desired_state: false

    # this config will pass to mongodb rs.initiate() or rs.reconfig() function as member item
    property :replication, Hash, coerce: proc { |c| coerce_mongodb_replication(c) }, default: {}, desired_state: false

    def replication_name
      config['replication'] ? config['replication']['replSetName'] : nil
    end

    action_class do
      def whyrun_supported?
        true
      end
    end

    action :create do
      file new_resource.config_path do
        content YAML.dump(new_resource.config)

        user new_resource.user
        group new_resource.group
        mode '0644'
      end

      directory new_resource.config['storage']['dbPath'] do
        recursive true

        user new_resource.user
        group new_resource.group
        mode '0755'
      end

      directory ::File.dirname(new_resource.config['systemLog']['path']) do
        recursive true

        user new_resource.user
        group new_resource.group
        mode '0755'

        only_if { new_resource.config['systemLog']['destination'] == 'file' }
      end

      if replication_name
        # compile time: 'set automatic attributes for the discovery'
        node.automatic['mongodb']['lib']['discovery'][replication_name][new_resource.instance_name] = new_resource.replication # ~FC019 ~FC047
      end
    end
  end
end
