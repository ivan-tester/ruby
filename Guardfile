# frozen_string_literal: true

clearing :on

# For Emacs
ignore(/.*flycheck_/)
ignore(/#.*#/)

guard :bundler do
  watch('Gemfile')
end

group :main, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec rspec', results_file: '/tmp/spec.result' do
    watch(%r{spec/.+_spec.rb})
    watch('spec/spec_helper.rb') { 'spec' }
    watch('libraries/matchers.rb') { 'spec' }

    #### Project hardcoded matchers ####
    # Spec cookbook (each recipe is related to specs' folder with corresponding tests)
    watch(%r{test/fixtures/cookbooks/mongodb-lib-spec/recipes/(?<name>.+)\.rb}) { |m| "spec/#{m[:name]}" }
    # Libraries
    watch(%r{libraries/mongodb_package_.+\.rb$}) { 'spec/mongodb_package' }
    watch(%r{libraries/mongodb_repo_.+\.rb$}) { 'spec/mongodb_repo' }
    watch(%r{libraries/mongodb_service_.+\.rb$}) { 'spec/mongodb_service' }
    watch(%r{libraries/mongodb_replicaset\.rb$}) { 'spec/mongodb_replicaset' }
    watch(%r{libraries/mongodb_shard\.rb$}) { 'spec/mongodb_shard' }
    watch(%r{libraries/mongodb\.rb$}) { 'spec/mongodb' }
    watch(%r{libraries/mongos\.rb$}) { 'spec/mongos' }
    watch(%r{libraries/helpers_mongodb\.rb$}) { 'spec/mongodb' }
    watch(%r{libraries/helpers_replicaset\.rb$}) { 'spec/mongodb_replicaset' }
    watch(%r{libraries/helpers_shard\.rb$}) { 'spec/mongodb_shard' }
    watch(%r{libraries/helpers_recipe\.rb$}) { 'spec' }

    # RSpec shared examples
    watch('spec/support/shared_example_for_service.rb') { 'spec/mongodb_service' }
    watch('spec/support/shared_example_for_mongodb.rb') { 'spec/mongodb' }
    watch('spec/support/shared_example_for_mongodb_replicaset.rb') { 'spec/mongodb_replicaset' }
  end

  guard :rubocop, cli: %(-f fu -D), notification: true do
    watch(/.+\.rb$/)
    watch('Rakefile')
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :foodcritic, cli: '--epic-fail any --progress --chef-version 12', cookbook_paths: '.' do
    watch(%r{attributes/.+\.rb$})
    watch(%r{providers/.+\.rb$})
    watch(%r{recipes/.+\.rb$})
    watch(%r{resources/.+\.rb$})
    watch(%r{templates/.+$})
    watch('metadata.rb')
  end

  # guard :kitchen do
  #   watch(%r{^test/fixtures/cookbooks/mongodb-lib-test/.+})
  #   watch(%r{^test/integration/.+})
  #   watch(%r{^recipes/(.+)\.rb$})
  #   watch(%r{^attributes/(.+)\.rb$})
  #   watch(%r{^files/(.+)})
  #   watch(%r{^templates/(.+)})
  #   watch(%r{^libraries/(.+)\.rb$})
  #   watch(%r{^providers/(.+)\.rb$})
  #   watch(%r{^resources/(.+)\.rb$})
  # end
end
