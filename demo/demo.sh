#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname "$0")"
cd ..

make binaries

cleanup() {
  kill $(jobs -p)
}

trap cleanup EXIT

./build/infrakit-instance-vagrant &
./build/infrakit-flavor-combo &
./build/infrakit-flavor-vanilla &
./build/infrakit-flavor-zookeeper &
./build/infrakit-group-default &

echo 'Try running build/infrakitgroup watch --name group plugin/flavor/zookeeper/vagrant-zk-docker-example.json'
wait
