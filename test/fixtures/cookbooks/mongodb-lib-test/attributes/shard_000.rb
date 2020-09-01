# frozen_string_literal: true

default['mongodb']['test']['mongodb-sh-000-primary'] = {
  'config' => {
    'net' => {
      'port' => 27018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-000'
    },
    'sharding' => {
      'clusterRole' => 'shardsvr'
    }
  },
  'replication' => {
    '_id' => 0
  }
}

default['mongodb']['test']['mongodb-sh-000-secondary'] = {
  'config' => {
    'net' => {
      'port' => 29018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-000'
    },
    'sharding' => {
      'clusterRole' => 'shardsvr'
    }
  },
  'replication' => {
    '_id' => 1
  }
}

default['mongodb']['test']['mongodb-sh-000-arbiter'] = {
  'config' => {
    'net' => {
      'port' => 30018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 1,
      'replSetName' => 'sh-000'
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

default['mongodb']['test']['mongodb-sh-000-hidden'] = {
  'config' => {
    'net' => {
      'port' => 31018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-000'
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

default['mongodb']['test']['mongodb-sh-000-delayed'] = {
  'config' => {
    'net' => {
      'port' => 32018,
      'bindIp' => '0.0.0.0'
    },
    'replication' => {
      'oplogSizeMB' => 32,
      'replSetName' => 'sh-000'
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
