#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

docker run -d --restart=always -v $(pwd):/config:ro -p 5000:5000 --name infrakit-demo-registry-cache registry:2 /config/config.yml
