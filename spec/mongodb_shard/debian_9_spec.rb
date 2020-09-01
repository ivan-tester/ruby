# frozen_string_literal: true

require 'spec_helper'

describe 'mongodb-lib-spec::mongodb_shard' do
  context 'on Debian (9)' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'debian', version: '9.0') do |node, server|
        load_nodes(server)
      end.converge described_recipe
    end

    it 'should add shards' do
      expect(chef_run).to add_mongodb_shard('spec-sh-000')
      expect(chef_run).to add_mongodb_shard('spec-sh-001')
    end
  end
end
