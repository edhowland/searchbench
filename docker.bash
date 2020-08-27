#!/bin/bash
# docker.bash - like docker.run but puts in new entrypoint : /bin/bash
# Must pass filename and run count in that order
docker run --rm -it --entrypoint bash   -v ${HOME}:${HOME} -v ${PWD}:/work --name=my-bench edhowland/searchbench $1 $2
