#!/bin/bash
# mkimport-sql.sh : Run this and pipe it to sqlite3 <database.db>
# Usage: ./mkimport-sql.sh fullrun.csv | sqlite3 benchmark.db
cat <<EOD
.mode csv
.import "$1" runs
EOD


