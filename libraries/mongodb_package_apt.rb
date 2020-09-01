# frozen_string_literal: true

require_relative 'mongodb_package_base'

module MongoDBLibCookbook
  class MongodbPackageApt < MongodbPackageBase
    resource_name :mongodb_package_apt

    provides :mongodb_package, platform_family: 'debian'
    provides :mongodb_package_apt, os: 'linux'

    action_class do
      def whyrun_supported?
        true
      end
    end

    action :install do
      package new_resource.name do
        version new_resource.version
      end
    end

    action :remove do
      package new_resource.name do
        action :remove
      end
    end
  end
end
