#!/bin/bash
# sourced by bench_run.sh : Contains all relavelant functions
TIMEFORMAT='%3R,%3U,%3S' # set a custom time format

run() {
  cmd="$1"  # The command to run
  file="$2" # The file to search
  rnum="$3" # The run number
  log running "$cmd" for "$file" for run number "$rnum"
  echo -n "${rnum},${cmd},${file},"
  { time "$cmd" "$file" >/dev/null ;} 2>&1
  log "$cmd" returned "$?"
}


fn.find() {
  find / -name "$1"
}
# Run the searchers

# bench() runs the benchmark run
bench() {
for i in "$@"
do
  log bench: running search for "$filename" for run number "$run_number"
  find.first  "$i" "$filename"
  log ":"
  run "$i" "$filename" "$run_number"
done
}


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
