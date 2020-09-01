# frozen_string_literal: true

module MongoDBLibCookbook
  # This resource manages mongodb service
  # @param start enables and starts service
  # @param stop stops and disables service
  class MongodbServiceBase < Chef::Resource
    property :instance_name, String, name_property: true, required: true, desired_state: false
    property :config_path, String, default: lazy { default_config_path }, desired_state: false
    property :daemon_path, String, default: '/usr/bin/mongod', desired_state: false
    property :user, String, default: lazy { default_mongodb_user }, desired_state: false
    property :group, String, default: lazy { default_mongodb_group }, desired_state: false

    # cookbook where to lookup service template
    property :template_cookbook, String, default: 'mongodb-lib', desired_state: false

    default_action :start
    allowed_actions :start, :stop, :restart

    include MongoDBLibHelpers::Mongodb
  end
end
