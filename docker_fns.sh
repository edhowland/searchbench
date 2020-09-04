#!/bin/bash
# docker_fns.sh : functions for docker run scripts
bench.log.date() {
  echo -n bench.log.
  date +'%Y.%m.%d.%H.%M.%S'
}
# compute the name of the image:tag
bench.img() {
  echo "edhowland/searchbench:$(cat docker.tag)"
}
# Main entry point
docker.act() {
  docker run --rm -v ${HOME}:${HOME} -v ${PWD}:/work $@ 
}
# move any old bench.log to timestamped backups
move_logs() {
test -f bench.log && { mv bench.log $(bench.log.date) ;}
}
