# frozen_string_literal: true

require 'spec_helper'

describe 'mongodb-lib-spec::mongos' do
  context 'on Debian (9)' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'debian',
        version: '9.0',
        step_into: 'mongodb'
      ).converge described_recipe
    end

    it 'install mongos' do
      expect(chef_run).to create_mongos('mongos')
    end
  end
end
