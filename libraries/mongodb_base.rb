# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbBase < Chef::Resource
    property :instance_name, String, name_property: true, required: true, desired_state: false
    property :user, String, default: lazy { default_mongodb_user }, desired_state: false
    property :group, String, default: lazy { default_mongodb_group }, desired_state: false

    property :config_path, String, default: lazy { default_config_path }, desired_state: false

    default_action :create
    allowed_actions :create

    include MongoDBLibHelpers::Mongodb
  end
end
