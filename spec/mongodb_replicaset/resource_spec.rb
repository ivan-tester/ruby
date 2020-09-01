# frozen_string_literal: true

require 'spec_helper'

describe MongoDBLibCookbook::MongodbReplicaset do
  subject(:mongodb_replicaset) { described_class.new('chefspec-replicaset') }

  describe '.coerce_mongodb_replicaset_config' do
  end

  describe '.replicaset_config_valid?' do
    context 'when config is nil or empty' do
      it do
        expect(mongodb_replicaset.replicaset_config_valid?(nil)).to be_falsy
        expect(mongodb_replicaset.replicaset_config_valid?({})).to be_falsy
        expect(mongodb_replicaset.replicaset_config_valid?(foo: 'bar')).to be_falsy
      end
    end

    context 'when config lacks of _id' do
      it do
        expect(mongodb_replicaset.replicaset_config_valid?('members' => [])).to be_falsy
      end
    end

    context 'when config is valid' do
      let(:config) do
        {
          '_id' => 'chefspec-replicaset',
          'members' => [
            { '_id' => 0, 'host' => 'HOST:12000' },
            { '_id' => 1, 'host' => 'HOST:12001' }
          ]
        }
      end

      it do
        expect(mongodb_replicaset.replicaset_config_valid?(config)).to be_truthy
      end
    end
  end
end
