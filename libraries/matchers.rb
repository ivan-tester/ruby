# frozen_string_literal: true

if defined?(ChefSpec)
  # matcher => [methods]
  {
    :mongodb => %w[create],
    :mongodb_repo => %w[add remove],
    :mongodb_repo_apt => %w[add remove],
    :mongodb_repo_yum => %w[add remove],
    :mongodb_package => %w[install remove],
    :mongodb_package_apt => %w[install remove],
    :mongodb_package_yum => %w[install remove],
    :mongodb_service => %w[start stop restart],
    :mongos => %w[create],
    :mongodb_replicaset => %w[configure],
    :mongodb_shard => %w[add]
  }.each_pair do |resource, actions|
    ChefSpec.define_matcher resource

    actions.each do |action|
      define_method("#{action}_#{resource}") do |resource_name|
        ChefSpec::Matchers::ResourceMatcher.new(resource, action.to_sym, resource_name)
      end
    end
  end
end
