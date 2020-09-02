#!/bin/bash
# The inner single benchmark runner. Will be called N times by bench.sh

source ./bench_log.sh
source ./bench_fns.sh
source ./bench_fns_log.sh

bench_pass() {
filename="$1"
test -z "$filename" && filename=README.md
run_number="$2"
test -z "$run_number" && run_number=1




# Run all the searchers
bench fn.locate fn.mlocate fn.find fn.fd

# Now run the matchers

filename=$(echo "$filename" | sed -e 's/\./\\./')
log Modified filename is "$filename"
bench fn.fgrep fn.ack fn.ag fn.rg


}
