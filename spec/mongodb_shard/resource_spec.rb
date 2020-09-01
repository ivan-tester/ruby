# frozen_string_literal: true

require 'spec_helper'

describe MongoDBLibCookbook::MongodbShard do
  subject(:mongodb_shard) { described_class.new('chefspec-shard') }

  describe '.coerce_mongodb_shard_config' do
  end

  describe '.shard_config_valid?' do
    context 'when config is nil or empty' do
      it do
        # expect(mongodb_shard.shard_config_valid?(nil)).to be_falsy
        # expect(mongodb_shard.shard_config_valid?({})).to be_falsy
        # expect(mongodb_shard.shard_config_valid?(foo: 'bar')).to be_falsy
      end
    end

    context 'when config lacks of _id' do
      it do
        # expect(mongodb_shard.shard_config_valid?('members' => [])).to be_falsy
      end
    end

    context 'when config is valid' do
      it do
        # expect(mongodb_shard.shard_config_valid?(config)).to be_truthy
      end
    end
  end
end
