# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbServiceSysvinitDebian < MongodbServiceBase
    resource_name :mongodb_service_sysvinit_debian

    provides :mongodb_service, platform: 'debian' do |node| # ~FC005
      node['platform_version'].to_f < 8.0
    end

    provides :mongodb_service, platform: 'ubuntu' do |node|
      node['platform_version'].to_f < 12.04
    end

    provides :mongodb_service_sysvinit_debian, platform_family: 'debian'

    action_class do
      def whyrun_supported?
        true
      end

      def service_resource
        find_resource(:service, name) || service(name) do
          # Init unable to turn off the service
          provider Chef::Provider::Service::Insserv
          supports status: true, restart: true

          only_if { ::File.exist? "/etc/init.d/#{name}" }

          action :nothing
        end
      end

      def init_template_resource
        find_resource(:template, "/etc/init.d/#{name}") || template("/etc/init.d/#{name}") do
          source 'sysvinit/mongodb-debian.erb'
          variables :new_resource => new_resource

          owner 'root'
          group 'root'
          mode '0755'

          cookbook 'mongodb-lib'

          action :nothing
        end
      end
    end

    action :start do
      init_template_resource.action = :create
      service_resource.action = [:enable, :start]
      init_template_resource.notifies :restart, service_resource
    end

    action :stop do
      service_resource.action = [:stop, :disable]
    end

    action :restart do
      action_stop
      action_start
    end
  end
end
