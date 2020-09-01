#!/bin/bash
# log functions
log_fname=/work/bench.log
log() {
  ((BENCH_LOG == 1)) && echo "$@" >> $log_fname
}
# This logp function works like above, but works as a end point in a pipeline
logp() {
  if ((BENCH_LOG == 1))
  then
    cat >>  $log_fname
  else
    cat >> /dev/null
  fi
}

# echo to stderr
erro() {
  cat <<< "$@" >&2
}
# Both echo to stderr and also log it
loge() {
  log "$@"
  erro "$@"
}


