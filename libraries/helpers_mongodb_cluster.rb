# frozen_string_literal: true

module MongoDBLibCookbook
  module MongoDBLibHelpers
    module MongodbCluster
      # Use should not load gem too early on compile
      # because it might hasn't be installed yet
      # so do it explicitly in any method requires mongo
      def load_mongo_gem
        return if @gem_loaded

        gem 'mongo', '>= 2.4'
        require 'mongo'

        @gem_loaded = true
      end

      # work with mongo connection
      # @param [String] addresses addresses to connect to
      # @param [Hash] options mongodb client options
      # @yield [client] run block with connection
      # @return result of block execution or nil if mongo error
      def with_mongodb_connection(addresses, options)
        return unless addresses

        load_mongo_gem

        client = Mongo::Client.new(addresses, options)

        yield(client)
      rescue Mongo::Error => e
        Chef::Log.warn("Mongodb connection error for #{addresses}: #{e}")
        nil
      ensure
        client.close if client
      end

      # Valid configuration file must follow:
      # https://docs.mongodb.com/manual/reference/replica-configuration/
      # @param [Hash] member
      # @option member [Integrer] _id id
      # @option member [String] host host:port
      def replicaset_member_valid?(member)
        return false unless member && member['_id']
        return false unless member['host'] =~ /^[\w\.\-]+:\d+/

        true
      end

      # Valid configuration file must follow:
      # https://docs.mongodb.com/manual/reference/replica-configuration/
      # @param [Hash] config replicaset configuration
      # @option config [String] _id replication name
      # @option config [Array] members list of members
      # @return [Boolean] true if configuration hash seems valid
      def replicaset_config_valid?(config)
        return false unless config && config['_id']
        return false unless config['members'].respond_to?(:each) && config['members'].any?

        config['members'].each do |member|
          return false unless replicaset_member_valid?(member)
        end

        true
      end

      # Guess if a member is writeable and visible in replicaset
      # We use such members when configure/reconfigure replicaset
      # @return [Boolean] whether member writable?
      def replicaset_writeable_member?(member)
        replicaset_member_valid?(member) &&
          !member['arbiteronly'] &&
          !member['hidden'] &&
          !(member['votes'] && member['votes'].zero?) &&
          !(member['slaveDelay'] && !member['slaveDelay'].zero?)
      end

      # @param [Array] members replicaset configuration
      # @return [Array] configuration members which can become primary
      def replicaset_writeable_members(members)
        members.select do |member|
          replicaset_writeable_member?(member)
        end
      end

      # Returns actual replicaset configuration from specified desired configuration
      # @param [Hash] config desired replicaset config
      # @return [Hash,nil] actual config or nil
      def replicaset_config(config)
        addresses = config['members'].map { |m| m['host'] }

        with_mongodb_connection(addresses, database: 'admin') do |client|
          client.command(replSetGetConfig: 1).first['config'].to_h
        end
      end

      # call initial configuration with specified config
      # @param [Hash] config replicaset config
      def configure_replicaset(config)
        raise "Invalid config #{config}" unless replicaset_config_valid?(config)

        address = replicaset_writeable_members(config['members']).first['host']

        with_mongodb_connection([address], database: 'admin', connect: :direct) do |client|
          client.command(replSetInitiate: config)
        end
      end

      # call reconfiguration configuration with specified config
      # @param [Hash] config replicaset config
      def reconfigure_replicaset(config)
        raise "Invalid config #{config}" unless replicaset_config_valid?(config)

        # Increase version for new replicaset configuration
        config['version'] = replicaset_config(config)['version'] + 1

        addresses = config['members'].map { |m| m['host'] }

        with_mongodb_connection(addresses, database: 'admin') do |client|
          client.command(replSetReconfig: config)
        end
      end

      # Get all shards from specified router
      # @param [String] router host:port of the router to connect to
      def list_shards(router)
        with_mongodb_connection([router], database: 'admin') do |client|
          client.command(listShards: 1).first['shards']
        end
      end

      # Adds shard to mongodb cluster
      # Consider: https://docs.mongodb.com/manual/reference/command/addShard/
      # @param [String] router router to connect to
      # @param [String] shard_name name of the new shard
      # @param [Array, String] shard connection string either host:port of replicaset name
      # @param [Integer] max_size maxium size of shard. 0 - infinity
      def add_shard(router, shard_name, shard, max_size)
        if shard.is_a? Array
          config = {
            '_id' => 'autogenerated-for-discovery',
            'members' => shard
          }

          # Let re-read actual config from the replicaset and use actual data
          config = replicaset_config(config)
          members = replicaset_writeable_members(config['members'])
          hosts = members.map { |m| m['host'] }
          shard = "#{config['_id']}/#{hosts.join(',')}"
        end

        with_mongodb_connection([router], database: 'admin') do |client|
          client.command(addShard: shard, maxSize: max_size, name: shard_name)
        end
      end
    end
  end
end
