# frozen_string_literal: true

shared_examples 'mongodb' do |opts|
  let(:mongodb) { chef_run.mongodb(opts[:instance_name]) }
  let(:config) { mongodb.config }
  let(:replication) { mongodb.replication }

  it 'creates config' do
    expect(chef_run).to render_file(mongodb.config_path)
  end

  it 'has not ruby types in yaml' do
    expect(chef_run).to render_file(mongodb.config_path).with_content { |content|
      expect(content).to_not include('!ruby')
    }
  end

  it 'creates db directory' do
    expect(chef_run).to create_directory(opts[:db_directory])
  end

  it 'creates log directory' do
    expect(chef_run).to create_directory(opts[:log_directory])
  end

  it 'has correct actions' do
    opts[:actions].each do |action|
      case action
      when 'create'
        expect(chef_run).to create_mongodb(opts[:instance_name])
      else
        fail "Unsupported action #{action} for #{mongodb}"
      end
    end
  end

  it "has replication" do
    expect(replication).to include(opts[:replication])
  end if opts[:replication]
end
