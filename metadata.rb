# frozen_string_literal: true

name             'mongodb-lib'
maintainer       'Yauhen Artsiukhou'
maintainer_email 'jsirex@gmail.com'
license          'MIT'
description      'Provides library functions for managing mongodb'
long_description 'Provides library functions for managing mongodb'
issues_url       'https://github.com/jsirex/mongodb-lib-cookbook/issues/' if respond_to?(:issues_url)
source_url       'https://github.com/jsirex/mongodb-lib-cookbook' if respond_to?(:source_url)
version          '0.3.0'

supports 'debian'
supports 'ubuntu'
supports 'centos'

depends 'apt'
depends 'yum'
depends 'build-essential'

# We use 13 chef but it should be compatible with 12.7
chef_version '>= 12.7'

# Provided recipes
recipe 'mongodb-lib::mongo_gem', 'Installs mongo gem in compile time. Required for cluster operations'

# Automatically installed gems before chef run (new in 12.8)
# gem 'mongo', '>= 2.4.0'
