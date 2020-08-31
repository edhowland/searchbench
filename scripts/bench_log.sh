#!/bin/bash
# log functions
log_fname=/work/bench.log
log() {
  ((BENCH_LOG == 1)) && echo "$@" >> $log_fname
}
