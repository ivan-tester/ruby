# frozen_string_literal: true
mongodb 'single'

mongodb 'mongodb-primary' do
  config 'net' => {
           'bindIp' => '0.0.0.0'
         },
         'replication' => {
           'replSetName' => 'rs'
         }

  replication '_id' => 0
end

m = Mash.new
m['systemLog'] = { 'destination' => 'syslog' }
m['replication'] = { 'replSetName' => 'rs' }
m['net'] = { 'port' => 27018 }

mongodb 'mongodb-secondary' do
  config m

  replication(
    '_id' => 1,
    'priority' => 0.5
  )
end

mongodb 'mongodb-delayed' do
  config 'replication' => {
           'replSetName' => 'rs'
         }

  replication(
    '_id' => 3,
    'host' => "#{node['fqdn'].upcase}:27017",
    'priority' => 0,
    'hidden' => true,
    'slaveDelay' => 3600 # 1 hour
  )
end

mongodb 'mongodb-hidden' do
  config 'replication' => {
           'replSetName' => 'rs'
         }

  replication(
    '_id' => 4,
    'host' => "#{node['fqdn']}:27017",
    'priority' => 0,
    'hidden' => true
  )
end

mongodb 'mongodb-arbiter' do
  config 'replication' => {
           'replSetName' => 'rs'
         }

  replication(
    '_id' => 5,
    'arbiterOnly' => true
  )
end
