mongodb_service 'default-action'

mongodb_service 'start' do
  action :start
end

mongodb_service 'stop' do
  action :stop
end

mongodb_service 'config-provided' do
  config_path '/mongodb.conf'
  action [:stop, :start]
end

mongodb_service 'router' do
  daemon_path '/usr/bin/mongos'
  action :restart
end
