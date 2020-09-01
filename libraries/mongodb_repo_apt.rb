# frozen_string_literal: true

require_relative 'mongodb_repo_base'

module MongoDBLibCookbook
  class MongodbRepoApt < MongodbRepoBase
    resource_name :mongodb_repo_apt

    provides :mongodb_repo, platform_family: 'debian'
    provides :mongodb_repo_apt, os: 'linux'

    property :keyserver, String, default: lazy { default_keyserver }, desired_state: false
    property :key, String, default: lazy { default_key }, desired_state: false

    def default_keyserver
      'hkp://keyserver.ubuntu.com:80'
    end

    def default_key
      case version
      when '3.6'
        '2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5'
      when '4.0'
        '9DA31620334BD75D9DCB49F368818C72E52529D4'
      when '4.2'
        '4B7C549A058F8B6B'
      else
        'UNSUPPORTED VERSION KEY'
      end
    end

    action_class do
      def repository_name
        "#{node['lsb']['codename']}-mongodb-org-#{new_resource.version}"
      end

      def whyrun_supported?
        true
      end
    end

    action :add do
      apt_repository repository_name do
        uri "http://repo.mongodb.org/apt/#{node['platform']}"
        distribution "#{node['lsb']['codename']}/mongodb-org/#{new_resource.version}"

        case node['platform']
        when 'debian'
          components ['main']
        when 'ubuntu'
          components ['multiverse']
        end

        keyserver new_resource.keyserver
        key new_resource.key
        action :add
      end
    end

    action :remove do
      apt_repository repository_name do
        action :remove
      end
    end
  end
end
