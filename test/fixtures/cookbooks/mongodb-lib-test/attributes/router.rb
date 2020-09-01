# frozen_string_literal: true
default['mongodb']['test']['router-1']['config'] = {
  'net' => {
    'port' => 27017,
    'bindIp' => '0.0.0.0'
  },
  'sharding' => {
    'configDB' => 'config/dokken:27019,dokken:29019,dokken:30019'
  }
}

default['mongodb']['test']['router-2']['config'] = {
  'net' => {
    'port' => 28017,
    'bindIp' => '0.0.0.0'
  },
  'sharding' => {
    'configDB' => 'config/dokken:27019,dokken:29019,dokken:30019'
  }
}
