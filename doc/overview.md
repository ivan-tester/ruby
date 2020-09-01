This cookbook provides library functions for installing mongodb `>= 3.2`.

It tries to do as less as possible.


# Notes

## Replicaset

Replicaset configuration must has all required values as described in official documentation.
Replicaset version may be omitted, because if topology will change cookbook can schedule reconfiguration.

Because mongodb itself adds to configuration some default values it is really hard to preserve idempotency.
Thats why algorithm is a bit complicated. See the picture:

![replicaset configuration](https://raw.githubusercontent.com/jsirex/mongodb-lib-cookbook/master/doc/replication.png)


## Sharding

Cookbooks can add shard to a cluster of mongodb. If shard already exist it skips addition.

# Examples of usage

Please consider fixtures cookbooks under `test/fixtures/cookbooks` path.
