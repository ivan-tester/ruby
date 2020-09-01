require 'spec_helper'

describe 'mongodb-lib-spec::mongodb_repo' do
  context 'on Centos (7)' do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos',
        version: '7.3.1611',
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
      it 'adds yum repository 12.34' do
        expect(chef_run).to create_yum_repository('mongodb-org-12.34').with(
          baseurl: 'https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/12.34/x86_64/'
        )
      end

      it 'removes yum repository 3.4' do
        expect(chef_run).to delete_yum_repository('mongodb-org-3.4')
      end
    end
  end
end
