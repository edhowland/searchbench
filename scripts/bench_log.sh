#!/bin/bash
# log functions
log_fname=bench.log
log() {
  ((BENCH_LOG == 1)) && echo "$@" >> $log_fname
}
