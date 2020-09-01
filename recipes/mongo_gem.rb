# frozen_string_literal: true

build_essential 'install-build-essential' do
  compile_time true
end

chef_gem 'mongo' do
  version '>= 2.4.0'
  compile_time true
end
