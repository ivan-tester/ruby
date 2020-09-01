# frozen_string_literal: true

require 'spec_helper'

describe 'mongodb-lib-spec::mongodb_replicaset' do
  context 'on Debian (9)' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'debian', version: '9.0') do |node, server|
        load_nodes(server)
      end.converge described_recipe
    end

    it_should_behave_like 'mongodb replicaset',
                          name: 'spec-config',
                          members: [
                            'fauxhai.local:27019',
                            'fauxhai.local:29019',
                            'fauxhai.local:30019'
                          ]

    it_should_behave_like 'mongodb replicaset',
                          name: 'spec-sh-000',
                          members: [
                            'fauxhai.local:27018',
                            'fauxhai.local:29018',
                            'fauxhai.local:30018',
                            'fauxhai.local:31018',
                            'fauxhai.local:32018'
                          ]

    # testing reverse order by _id
    it_should_behave_like 'mongodb replicaset',
                          name: 'spec-sh-001',
                          members: [
                            'fauxhai.local:37018',
                            'fauxhai.local:36018',
                            'fauxhai.local:35018',
                            'fauxhai.local:34018',
                            'fauxhai.local:33018'
                          ]
    end
end
