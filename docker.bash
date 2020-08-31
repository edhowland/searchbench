#!/bin/bash
# docker.bash - like docker.run but puts in new entrypoint : /bin/bash
docker run --rm -it --entrypoint bash   -v ${HOME}:${HOME} -v ${PWD}:/work --name=my-bench edhowland/searchbench:$(cat docker.tag)
