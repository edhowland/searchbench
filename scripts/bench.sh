#!/bin/bash
# Master control program to run benchmark runs
source ./bench_log.sh
filename="$1"
test -z "$filename" && filename=README.md
run_count="$2"
test -z "$run_count" && run_count=3

./bench_init.sh "$filename" || exit $?
log Will run benchmark searching for "$filename" "$run_count" times


log Will run "$run_count" times
for ((n=1; n <= "$run_count"; n++))
do
  log Starting run: "$n" "================"
  ./bench_run.sh "$filename" "$n"
  log Stopping run: "$n" "================"
done
# erase any non-zero exit status cruft accumulated above
exit 0


