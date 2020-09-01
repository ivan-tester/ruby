# frozen_string_literal: true

shared_examples 'mongodb replicaset' do |opts|
  let(:mongodb_replicaset) { chef_run.mongodb_replicaset(opts[:name]) }
  let(:mongodb_replicaset_hosts) { mongodb_replicaset.config['members'].map { |x| x['host'] } }
  let(:members) { opts[:members] }

  context opts[:name] do
    it { expect(mongodb_replicaset_hosts).to eq(members) }

    it { expect(chef_run).to configure_mongodb_replicaset(opts[:name]) }
  end
end
