# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbServiceSysvinitRhel < MongodbServiceBase
    resource_name :mongodb_service_sysvinit_rhel

    provides :mongodb_service, platform_family: 'rhel' do |node| # ~FC005
      node['platform_version'].to_f < 7.0
    end
  end
end
