# frozen_string_literal: true

require_relative 'mongodb_package_base'

module MongoDBLibCookbook
  class MongodbPackageYum < MongodbPackageBase
    resource_name :mongodb_package_yum

    provides :mongodb_package, platform_family: %w[rhel fedora]
    provides :mongodb_package_yum, os: 'linux'

    action_class do
      def whyrun_supported?
        true
      end
    end

    action :install do
      package new_resource.name do
        name "#{new_resource.name}-#{new_resource.version}" if new_resource.version
      end
    end

    action :remove do
      package new_resource.name do
        action :remove
      end
    end
  end
end
