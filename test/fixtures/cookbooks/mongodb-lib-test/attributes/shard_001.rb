# frozen_string_literal: true

default['mongodb']['test']['mongodb-sh-001-primary'] = {
  'config' => {
    'net' => {
      'port' => 33018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-001'
    },
    'sharding' => {
      'clusterRole' => 'shardsvr'
    }
  },
  'replication' => {
    '_id' => 0
  }
}

default['mongodb']['test']['mongodb-sh-001-secondary'] = {
  'config' => {
    'net' => {
      'port' => 34018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-001'
    },
    'sharding' => {
      'clusterRole' => 'shardsvr'
    }
  },
  'replication' => {
    '_id' => 1
  }
}

default['mongodb']['test']['mongodb-sh-001-arbiter'] = {
  'config' => {
    'net' => {
      'port' => 35018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 1,
      'replSetName' => 'sh-001'
    },
    'sharding' => {
      'clusterRole' => 'shardsvr'
    }
  },
  'replication' => {
    '_id' => 2,
    'arbiterOnly' => true
  }
}

default['mongodb']['test']['mongodb-sh-001-hidden'] = {
  'config' => {
    'net' => {
      'port' => 36018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-001'
    },
    'sharding' => {
      'clusterRole' => 'shardsvr'
    }
  },
  'replication' => {
    '_id' => 3,
    'priority' => 0,
    'hidden' => true
  }
}

default['mongodb']['test']['mongodb-sh-001-delayed'] = {
  'config' => {
    'net' => {
      'port' => 37018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-001'
    },
    'sharding' => {
      'clusterRole' => 'shardsvr'
    }
  },
  'replication' => {
    '_id' => 4,
    'priority' => 0,
    'hidden' => true,
    'slaveDelay' => 3600
  }
}
