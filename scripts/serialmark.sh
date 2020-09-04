#!/bin/bash
# Like bench.sh master control program but runs each command serially
source ./bench_log.sh
source ./bench_run.sh

filename="$1"
test -z "$filename" && filename=README.md
run_count="$2"
test -z "$run_count" && run_count=3

loge Initializing search context
./bench_init.sh "$filename" || exit $?

cd / # set directory context for all participants
loge Will run benchmark searching for "$filename" "$run_count" times

for c in fn.locate fn.mlocate fn.find fn.fd fn.fgrep
do
  for ((n=1; n <= "$run_count"; n++))
  do
    run_number=$n
    bench $c
    loge Running pass $n for $c
  done
done

### Delete to the bottom from here
exit 0

for ((n=1; n <= "$run_count"; n++))
do
  log Starting run: "$n" "================"
  bench_pass "$filename" "$n"
  log Stopping run: "$n" "================"
done
# erase any non-zero exit status cruft accumulated above
exit 0


