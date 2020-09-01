# frozen_string_literal: true

module MongoDBLibCookbook
  # This class manages mongodb repositories
  class MongodbRepoBase < Chef::Resource
    property :version, String, name_property: true, coerce: proc { |v| coerce_repo_version(v) }, required: true, desired_state: false

    default_action :add
    allowed_actions :add, :remove

    include MongoDBLibHelpers::Repo
  end
end
