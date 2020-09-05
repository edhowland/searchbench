#!/bin/bash
# sourced by bench_run.sh : Contains all relavelant functions
#TIMEFORMAT='%3R,%3U,%3S,%x' # set a custom time format includes Real, User, Sys and exit code

run() {
  cmd="$1"  # The command to run
  file="$2" # The file to search
  rnum="$3" # The run number
  log running "$cmd" for "$file" for run number "$rnum"
  echo -n "${rnum},${cmd##*.},${file},"
  { $cmd "$file" >/dev/null ;} 2>&1
  log "$cmd" returned "$?"
}


fn.locate() {
fn.search locate
}
fn.mlocate() {
  fn.search mlocate
}
fn.find() {
  fn.search 'find / -name'
}
fn.fd() {
  fn.search fd
}
fn.fdfast() {
  fn.search 'fd -g'
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

fn.search() {
  cmd="$1"
  /usr/bin/time --quiet --format='%e,%U,%S,%x' $cmd "$filename"

}

fn.match() {
  cmd="$1"
  /usr/bin/time --quiet --format='%e,%U,%S,%x' $cmd "$filename" /work/dirs+files.lst
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
