#!/bin/bash
# Jumps into container with /bin/bash as entry point
source docker_fns.sh
docker.act -it --entrypoint /bin/bash $(bench.img)

