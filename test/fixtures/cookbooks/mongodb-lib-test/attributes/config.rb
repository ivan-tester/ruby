# frozen_string_literal: true

default['mongodb']['test']['mongodb-config-primary'] = {
  'config' => {
    'net' => {
      'port' => 27019,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'config'
    },
    'sharding' => {
      'clusterRole' => 'configsvr'
    }
  },
  'replication' => {
    '_id' => 0
  }
}

default['mongodb']['test']['mongodb-config-secondary'] = {
  'config' => {
    'net' => {
      'port' => 29019,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'config'
    },
    'sharding' => {
      'clusterRole' => 'configsvr'
    }
  },
  'replication' => {
    '_id' => 1
  }
}
