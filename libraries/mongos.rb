# frozen_string_literal: true

require_relative 'mongodb_base'

module MongoDBLibCookbook
  # This resource manages mongodb installation itself:
  # * config, data, log directories
  # * mongodb configuration file
  # Actions:
  # @param create creates instance
  class Mongos < MongodbBase
    resource_name :mongos

    provides :mongos, os: 'linux'

    property :config, Hash, coerce: proc { |c| coerce_mongos_config(c) }, default: {}, desired_state: false

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

      directory ::File.dirname(new_resource.config['systemLog']['path']) do
        recursive true

        user new_resource.user
        group new_resource.group
        mode '0755'

        only_if { new_resource.config['systemLog']['destination'] == 'file' }
      end
    end
  end
end
