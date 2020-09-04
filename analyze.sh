#!/bin/bash
# analyze.sh : Compute the ranking of averages of CSV runs using SQLite3
sql() {
  sqlite3 $db
}
csv=$1
db=$2
cat benchmark.schema | sql
./mkimport-sql.sh $csv |  sql
cat compute_avg.sql  | sql
cat rank-averages.sql | sql
