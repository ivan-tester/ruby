# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbServiceUpstart < MongodbServiceBase
    resource_name :mongodb_service_upstart

    provides :mongodb_service, platform: 'ubuntu'
    provides :mongodb_service_upstart, os: 'linux'
  end
end
