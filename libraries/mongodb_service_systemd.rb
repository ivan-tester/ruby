# frozen_string_literal: true

module MongoDBLibCookbook
  class MongodbServiceSystemd < MongodbServiceBase
    resource_name :mongodb_service_systemd

    provides :mongodb_service, platform: 'debian' do |node| # ~FC005
      node['platform_version'].to_f >= 8.0
    end

    provides :mongodb_service, platform: 'ubuntu' do |node|
      node['platform_version'].to_f >= 15.04
    end

    provides :mongodb_service, platform: %w[redhat centos scientific oracle] do |node|
      node['platform_version'].to_f >= 7.0
    end

    provides :mongodb_service, platform: 'fedora'
    provides :mongodb_service_systemd, os: 'linux'

    action_class do
      def whyrun_supported?
        true
      end

      # DRY: generate service resource for the further reuse
      def service_resource
        find_resource(:systemd_unit, "#{new_resource.name}.service") do
          content(
            'Unit' => {
              'Description' => "MongoDB #{new_resource.name} service",
              'After' => 'network.target',
              'Documentation' => 'https://docs.mongodb.org/manual'
            },
            'Service' => {
              'User' => new_resource.user,
              'Group' => new_resource.group,
              'ExecStart' => "#{new_resource.daemon_path} --config #{new_resource.config_path}",
              'RestartSec' => '3s',
              'Restart' => 'always',
              'LimitFSIZE' => 'infinity',
              'LimitCPU' => 'infinity',
              'LimitAS' => 'infinity',
              'LimitNOFILE' => 64000,
              'LimitNPROC' => 16000
            },
            'Install' => {
              'WantedBy' => 'multi-user.target'
            }
          )

          triggers_reload true

          action :nothing
        end
      end
    end

    action :start do
      service_resource.action += [:create, :enable, :start]
      service_resource.notifies :restart, service_resource, :delayed
    end

    action :stop do
      service_resource.action += [:stop, :disable]
    end

    action :restart do
      action_stop
      action_start
    end
  end
end
