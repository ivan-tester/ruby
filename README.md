# Description

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

# Requirements


## Chef Client:

* chef (>= 12.7) ()

## Platform:

* debian
* ubuntu
* centos

## Cookbooks:

* apt
* yum
* build-essential

# Attributes

* `node['mongodb']['lib']['version']` -  Defaults to `3.2.19`.

# Recipes

* mongodb-lib::mongo_gem - Installs mongo gem in compile time. Required for cluster operations

# License and Maintainer

Maintainer:: Yauhen Artsiukhou (<jsirex@gmail.com>)

Source:: https://github.com/jsirex/mongodb-lib-cookbook

Issues:: https://github.com/jsirex/mongodb-lib-cookbook/issues/

License:: MIT
