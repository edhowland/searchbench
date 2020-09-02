#!/bin/bash
# Setup
source ./bench_log.sh


find / > /work/dirs+files.lst

# First test for the pattern and if not found, get out of Dodge
filename="$1"
pattern=$(echo "$filename" | sed -e 's/\./\\./')

rg -q --quiet "$pattern" /work/dirs+files.lst|| { loge Could not find a single instance of "$1". Exitting ...; exit 2; }

# If there is at least one , then prep locate and mlocate with its search database
updatedb  # prep the locate, mlocate commands
