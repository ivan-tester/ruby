require 'spec_helper'

describe 'mongodb-lib-spec::mongodb_repo' do
  context 'on Ubuntu (16)' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'ubuntu',
        version: '16.04',
        step_into: 'mongodb_repo'
      ).converge described_recipe
    end

    it 'removes mongodb repo 3.4.8021' do
      expect(chef_run).to remove_mongodb_repo('3.4.8021')
    end

    it 'adds mongodb repo 12.34.56' do
      expect(chef_run).to add_mongodb_repo('12.34.56')
    end

    context 'step into mongodb_repo' do
      it 'adds xenial repository 12.34' do
        expect(chef_run).to add_apt_repository('xenial-mongodb-org-12.34').with(
          uri: 'http://repo.mongodb.org/apt/ubuntu',
          distribution: 'xenial/mongodb-org/12.34',
          components: ['multiverse']
        )
      end

      it 'removes apt repository 3.4' do
        expect(chef_run).to remove_apt_repository('xenial-mongodb-org-3.4')
      end
    end
  end
end
