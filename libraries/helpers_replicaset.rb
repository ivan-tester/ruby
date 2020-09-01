# frozen_string_literal: true

module MongoDBLibCookbook
  module MongoDBLibHelpers
    module MongodbReplicaset
      # @param [Hash] config replicaset configuration
      def coerce_mongodb_replicaset_config(config)
        config['members'].sort_by! { |m| m['_id'] }
        config['members'].each { |m| m['host'].downcase! }

        config
      end

      def save_replicaset_config(path, config)
        IO.write(path, config.to_json)
      end

      def load_replicaset_config(path)
        ::JSON.parse(IO.read(path))
      end
    end
  end
end
