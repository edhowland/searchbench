#!/bin/bash
# analyze.sh : Compute the ranking of averages of CSV runs using SQLite3

# echo to stderr
erro() {
  cat <<< "$@" >&2
}
sql() {
  sqlite3 $db
}
csv=$1
db=$2
cat benchmark.schema | sql
./mkimport-sql.sh $csv |  sql
erro There were $(cat errors-count.sql | sql)
cat compute_avg.sql  | sql
cat rank-averages.sql | sql
