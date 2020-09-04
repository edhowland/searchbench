#!/bin/bash
# Master control program to run benchmark runs
source ./bench_log.sh
source ./bench_run.sh

filename="$1"
test -z "$filename" && filename=README.md
run_count="$2"
test -z "$run_count" && run_count=3

log Initializing search context
./bench_init.sh "$filename" || exit $?

cd / # set directory context for all participants
log Will run benchmark searching for "$filename" "$run_count" times


for ((n=1; n <= "$run_count"; n++))
do
  log Starting run: "$n" "================"
  bench_pass "$filename" "$n"
  log Stopping run: "$n" "================"
done
# erase any non-zero exit status cruft accumulated above
exit 0


