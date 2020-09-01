shared_examples 'mongodb service' do |opts|
  let(:mongodb_service) { chef_run.mongodb_service(opts[:service_name]) }
  let(:implementation_class) { Object.const_get opts[:implementation_class] }

  it 'uses correct implementation class' do
    expect(mongodb_service.class).to eq(implementation_class)
  end

  it 'has correct config path' do
    expect(mongodb_service.config_path).to eq(opts[:config_path])
  end

  it 'has correct daemon path' do
    expect(mongodb_service.daemon_path).to eq(opts[:daemon_path])
  end

  it 'has correct actions' do
    opts[:actions].each do |action|
      case action
      when 'start'
        expect(chef_run).to start_mongodb_service(opts[:service_name])
        expect(chef_run).to create_systemd_unit("#{opts[:service_name]}.service")
        expect(chef_run).to enable_systemd_unit("#{opts[:service_name]}.service")
        expect(chef_run).to start_systemd_unit("#{opts[:service_name]}.service")

      when 'stop'
        expect(chef_run).to stop_mongodb_service(opts[:service_name])
        expect(chef_run).to stop_systemd_unit("#{opts[:service_name]}.service")
        expect(chef_run).to disable_systemd_unit("#{opts[:service_name]}.service")

      when 'restart'
        expect(chef_run).to restart_mongodb_service(opts[:service_name])
        expect(chef_run).to stop_systemd_unit("#{opts[:service_name]}.service")
        expect(chef_run).to start_systemd_unit("#{opts[:service_name]}.service")

      else
        fail "Action #{action} is not supported"
      end
    end
  end
end
