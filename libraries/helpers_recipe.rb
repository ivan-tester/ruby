# frozen_string_literal: true

module MongoDBLibCookbook
  module MongoDBLibHelpers
    # Define some methods for the recipe
    module MongodbRecipeDSL
      # Return mongodb replicaset compatible config from chef search
      # @param [String] env environment name to search with
      # @param [String] name replication set name
      # @return [Array] nodes with replicaset configuration compatible with resource mongodb_replicaset
      def search_mongodb_replicaset_members(env, name)
        rs_nodes = search(:node, "chef_environment:#{env} AND mongodb_lib_discovery_#{name}_*:*")

        rs_nodes.map { |n| n['mongodb']['lib']['discovery'][name].to_h.values }.flatten
      end
    end
  end
end

Chef::Recipe.send(:include, MongoDBLibCookbook::MongoDBLibHelpers::MongodbRecipeDSL)
