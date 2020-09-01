%w(mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools).each do |pkg|
  mongodb_package "remove-#{pkg}" do
    action :remove
  end

  mongodb_package pkg do
    version '12.34.56'
  end
end

mongodb_package 'mongodb-org-without-version'
