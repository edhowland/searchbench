#!/bin/bash
# The inner single benchmark runner. Will be called N times by bench.sh
source ./bench_log.sh

TIMEFORMAT='%3R,%3U,%3S' # set a custom time format
filename="$1"
test -z "$filename" && filename=README.md
run_number="$2"
test -z "$run_number" && run_number=1

run() {
  cmd="$1"  # The command to run
  file="$2" # The file to search
  rnum="$3" # The run number
  log running "$cmd" for "$file" for run number "$rnum"
  echo -n "${rnum},${cmd},${file},"
  { time "$cmd" "$file" >/dev/null ;} 2>&1
  log "$cmd" returned "$?"
}

# wrap the find command in a function to deal with needed arguments
fn.find() {
  find / -name "$1"
}
# Run the searchers

# bench() runs the benchmark run
bench() {
for i in "$@"
do
  log bench: running search for "$filename" for run number "$run_number"

  run "$i" "$filename" "$run_number"
done
}


# Run all the searchers
bench locate mlocate fn.find fdfind


# Now run the matchers
fn.match() {
  cmd="$1"
  $cmd "$filename" /work/dirs+files.lst
}
fn.fgrep() {
  fn.match fgrep
}
fn.ack() {
  fn.match ack
}
fn.ag() {
  fn.match 'ag --no-affinity'
}
fn.rg() {
  fn.match rg
}

filename=$(echo "$filename" | sed -e 's/\./\\./')
log Modified filename is "$filename"
bench fn.fgrep fn.ack fn.ag fn.rg

