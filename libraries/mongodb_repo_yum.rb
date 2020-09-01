# frozen_string_literal: true

module MongoDBLibCookbook
  require_relative 'mongodb_repo_base'

  class MongodbRepoYum < MongodbRepoBase
    resource_name :mongodb_repo_yum

    provides :mongodb_repo, platform_family: %w[rhel fedora]
    provides :mongodb_repo_yum, os: 'linux'

    action_class do
      def whyrun_supported?
        true
      end

      def repository_name
        "mongodb-org-#{new_resource.version}"
      end
    end

    action :add do
      yum_repository repository_name do
        description 'MongoDB Repository'
        baseurl "https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/#{new_resource.version}/x86_64/"
        gpgkey "https://www.mongodb.org/static/pgp/server-#{new_resource.version}.asc"
        enabled true
        action :create
      end
    end

    action :remove do
      yum_repository repository_name do
        action :delete
      end
    end
  end
end
