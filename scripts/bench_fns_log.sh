#!/bin/bash
# bench_fns_log.sh : Functions to handle find first of matching result and log it
source ./bench_log.sh

# This function is called from bench_run in the bench() function
# just before calling run(). It returns the find first function matching the
# the command usually passed to run(). E.g if run fn.rg, then returns fn1.rg
find.first() {
  if ((BENCH_LOG == 1))
  then

    declare -A fnmap
    fnmap[fn.locate]=fn1.locate
    fnmap[fn.mlocate]=fn1.mlocate
    fnmap[fn.find]=fn1.find
    fnmap[fn.fd]=fn1.fd
    fnmap[fn.fgrep]=fn1.fgrep
    fnmap[fn.ack]=fn1.ack
    fnmap[fn.ag]=fn1.ag
    fnmap[fn.rg]=fn1.rg

    log -n Using "$1" to find "$2" found @ ":"
    "${fnmap[$1]}" "$2"
  fi
}

# find first functions
fn1.locate() {
  locate "$1" | head -1 | logp
}
fn1.mlocate() {
  mlocate "$1" | head -1 | logp
}
fn1.find() {
  find / -name "$1" -print -quit | logp
}
fn1.fd() {
  fd  --max-results 1  "$1"  | logp
}
fn1.fgrep() {
  fgrep $1 /work/dirs+files.lst | head -1 | logp
  log "{in fn1.fgrep \[$1\] returned  ${PIPESTATUS[0]}}"
}
fn1.ack() {
  ack "$1" /work/dirs+files.lst | head -1  | logp
}
fn1.ag() {
  ag --no-affinity "$1" /work/dirs+files.lst | head -1  | logp
}
fn1.rg() {
  rg "$1" /work/dirs+files.lst | head -1 | logp
}
