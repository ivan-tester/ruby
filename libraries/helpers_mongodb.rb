# frozen_string_literal: true

module MongoDBLibCookbook
  module MongoDBLibHelpers
    module Mongodb
      def default_mongodb_user
        case node['platform_family']
        when 'rhel'
          'mongod'
        when 'debian'
          'mongodb'
        else
          'mongodb'
        end
      end

      def default_mongodb_group
        case node['platform_family']
        when 'rhel'
          'mongod'
        when 'debian'
          'mongodb'
        else
          'mongodb'
        end
      end

      def default_config_path
        "/etc/#{instance_name}.conf"
      end

      # MongoD requires minimal configuration to start.
      # We need to clear all nested classes with pure Hash,
      # thats why we have a stupid hash->json->hash conversion
      # @param [Hash, NilClass] config user input config
      # @return [Hash] minimal mongod configuration
      def coerce_mongodb_config(config)
        default = {
          'storage' => {
            'dbPath' => "/var/lib/#{instance_name}",
            'journal' => {
              'enabled' => true
            }
          },
          'systemLog' => {
            'destination' => 'file',
            'logAppend' => true,
            'path' => "/var/log/mongodb/#{instance_name}.log"
          },
          'net' => {
            'port' => 27017,
            'bindIp' => '127.0.0.1'
          }
        }

        JSON.parse(Chef::Mixin::DeepMerge.deep_merge(config, default).to_json)
      end

      # MongoS requires minimal configuration to start.
      # We need to clear all nested classes with pure Hash,
      # thats why we have a stupid hash->json->hash conversion
      # @param [Hash, NilClass] config user input config
      # @return [Hash] minimal mongod configuration
      def coerce_mongos_config(config)
        default = {
          'systemLog' => {
            'destination' => 'file',
            'logAppend' => true,
            'path' => "/var/log/mongodb/#{instance_name}.log"
          },
          'net' => {
            'port' => 27017,
            'bindIp' => '127.0.0.1'
          }
        }

        JSON.parse(Chef::Mixin::DeepMerge.deep_merge(config, default).to_json)
      end

      # mongodb requires at least host:port to be specified
      # _id field will be calculated on runtime
      def coerce_mongodb_replication(replication)
        default = {
          'host' => "#{node['fqdn']}:#{config['net']['port']}"
        }

        r = Chef::Mixin::DeepMerge.deep_merge(replication, default)
        r['host'] = r['host'].downcase

        JSON.parse(r.to_json)
      end
    end
  end
end
