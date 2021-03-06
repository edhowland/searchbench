#!/bin/bash
# Like bench.sh master control program but runs each command serially
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

# bench_act - Runs all arguments $run_count times each before advancing to next
bench_act() {
for c in $@
do
  for ((n=1; n <= "$run_count"; n++))
  do
    run_number=$n
    bench $c
    log Running pass $n for $c
  done
done
}

bench_act fn.locate fn.mlocate fn.find fn.fd fn.fdfast fn.fgrep

filename=$(echo "$filename" | sed -e 's/\./\\./g')
log Modified filename is "$filename"
bench_act fn.ack fn.ag fn.rg



exit 0 # subsume any extraneous errors from above passes