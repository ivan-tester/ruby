require 'spec_helper'

describe 'mongodb-lib-spec::mongodb_repo' do
  context 'on Debian (9)' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'debian',
        version: '9.0',
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
      it 'adds stretch repository 12.34' do
        expect(chef_run).to add_apt_repository('stretch-mongodb-org-12.34').with(
          uri: 'http://repo.mongodb.org/apt/debian',
          distribution: 'stretch/mongodb-org/12.34',
          components: ['main']
        )
      end

      it 'removes apt repository 3.4' do
        expect(chef_run).to remove_apt_repository('stretch-mongodb-org-3.4')
      end
    end
  end
end
