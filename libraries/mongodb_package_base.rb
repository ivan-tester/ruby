# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbPackageBase < Chef::Resource
    property :version, String, desired_state: false

    default_action :install
    allowed_actions :install, :remove
  end
end
