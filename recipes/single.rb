# frozen_string_literal: true

mongodb_repo node['mongodb']['lib']['version']

%w[mongodb-org-server mongodb-org-shell mongodb-org-tools].each do |pkg|
  mongodb_package pkg do
    version node['mongodb']['lib']['version']
  end
end

# Package has bundled mongodb instance, so we need only to start service
mongodb_service 'mongod'
