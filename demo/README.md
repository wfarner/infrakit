## InfraKit demo

This demo includes a few optimizations to build a ZooKeeper quorum quickly
with minimal reliance on an internet connection.  This is particularly useful
during public demos where WiFi may be flaky.

**For caching to be effective, run the demo before presenting.  Do not
terminate the Registry mirror as it uses volatile state.**

#### Run the Docker Registry mirror

```shell

$ ./registry-cache.sh
```

This runs a Docker Registry on your host, configured to cache Docker Hub.
Instances created are configured to use this as a mirror.

#### Run the demo components
```shell
  ./demo.sh
```

This will run all plugins necessary to create a ZK quorum.

#### Run CLI commands
```shell
$ ../build/infrakit group watch ../example/flavor/zookeeper/vagrant-zk-docker-registry.json
```

This will start watching a ZooKeeper quorum group, and create 3 instances.  There will be a small delay, after
which the shell running `./demo.sh` will report activity about creating missing instances:

```shell
INFO[0013] Logical ID 192.168.1.200 is missing, provisioning new instance
INFO[0013] Logical ID 192.168.1.201 is missing, provisioning new instance
INFO[0013] Logical ID 192.168.1.202 is missing, provisioning new instance
```

If you open the VirtualBox GUI, you will then see 3 virtual machines created.  The machines may take a few minutes
to boot.  The very first boot will take longer as Vagrant fetches the machine image.

Note: occasionally, Vagrant may fail due to the same image being downloaded multiple times simultaneously
(if not already cached).  This should be a transient issue that InfraKit recovers from automatically.


#### Watch the ZK quorum
```shell
$ ./monitor-zk.sh
```

This script polls the ZooKeeper node IP addresses and reports their
serving Mode, or `(down)` if unavailable.  This may be useful while
presenting to indicate when the ZooKeeper cluster is ready.


#### Clean up
Destroy the Group to clean up:
```shell
../build/infrakit group destroy zk
```

This will terminate all instances, but cached Docker and Vagrant images will remain.
