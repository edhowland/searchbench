# Searchbench - Docker image for benchmarking search methods

## Current Docker tag

edhowland/searchbench:0.1

This Docker container will benchmark 8 file/path search tools on a x86-64 Linux
system for a given filename. It will return its results in a CSV formatted to stdout.

## Dockerfile

[Dockerfile](https://github.com/edhowland/searchbench/blob/master/Dockerfile "Dockerfile used to build this image")


## Source on GitHub

The sources for this image can be found over at <https://github.com/edhowland/searchbench>

## Running the searchbench tool:

There are 2 mountpoints needed for the container to run the benchmark.
In the following examples below, the variables DOMAIN and SCRATCH are used instead
of hard coded values.

Note: **Make sure neither of these mount points are attached to a folder
containing any mounted network shares!**

- $DOMAIN The top level directory wherein you want to search for the passed in file. Volume is read-only
- $SCRATCH A scratchpad directory where searchbench will create some temporary files like log files and the'dirs+files.lst'. This mount point is read+write 

Note: DOMAIN should contain at least one existant file that you are using for the search.
And SCRATCH can be just any user writable location, perhaps $PWD.

```bash
$ docker run --rm -v ${DOMAIN}:/domain -v /tmp:/work edhowland/searchbench main.rs 10
```

Again note: ** Make sure '-v ${DOMAIN}' does not contain any mounted network shares**.

Finally, we give the filename to search for, here: main.rs,  and the number of benchmark
passes, in this case 10.

Note: Any files generated in the scratchpad folder mounted to /work in the container
might be write-protected. They can be removed with 'rm -f dirs+files.lst bench.log'


## Output format

The output written to  stdout is in comma separated value (CSV) format.
of raw passes for each tool benchmarked. The timer used is the GNU time program.

<https://www.gnu.org/software/time/>


Note: The benchmark installs the GNU time program and uses that version, not the 'time'
built in into Bash.

### Fields

1. Pass number: The number of this pass run.
2. Command : The name of the command used in the timing test.
3. The name of the file searched for.
4. The elapsed time Wall clock
5. The user time
6. The sys time
7. The exit status of the command

### Example

This example searched for the file 'main.rs' and ran 2 passes of the benchmark.

```
1,locate,main.rs,0.09,0.09,0.00,0
1,mlocate,main.rs,0.09,0.08,0.00,0
1,find,main.rs,1.08,0.44,0.63,0
1,fd,main.rs,0.49,1.14,0.78,0
1,fdfast,main.rs,0.49,1.09,0.82,0
1,fgrep,main.rs,0.04,0.00,0.00,0
2,locate,main.rs,0.09,0.09,0.00,0
2,mlocate,main.rs,0.08,0.08,0.00,0
2,find,main.rs,1.08,0.43,0.64,0
2,fd,main.rs,0.49,1.15,0.78,0
2,fdfast,main.rs,0.48,1.14,0.76,0
2,fgrep,main.rs,0.01,0.01,0.00,0
1,ack,main\.rs,0.52,0.40,0.02,0
1,ag,main\.rs,0.15,0.11,0.00,0
1,rg,main\.rs,0.02,0.02,0.00,0
2,ack,main\.rs,0.42,0.41,0.01,0
2,ag,main\.rs,0.12,0.11,0.00,0
2,rg,main\.rs,0.02,0.01,0.00,0
```


## The tools used

Note: In cases where the tool is listed without a link, it was installed in
the Docker image via the 'apt' tool. See the Dockerfile for exact package
requirements.

### The searchers

These tools recurse the directory tree and find a matching filename or pattern.
In the case of locate and mlocate, they rely on the tool 'updatedb' to have been
run beforehand, say, in a cron job. The searchbench script runs this first.

- locate
- mlocate
- find
- fd <https://github.com/sharkdp/fd>

### The matchers

These tools search against a list of paths and filenames generated with the
following command in the bench script:

```
find / > /work/dirs+files.lst
```

Once the searchbench tool has been run, this file will be created in  whichever
folder you mounted to /work  inside the container. E.g. ${PWD} or ${SCRATCH}.

All the following tools are grep-alike in their usage.

- fgrep
- ack
- ag (Also known as the Silver Searcher)
- rg <https://github.com/BurntSushi/ripgrep>

### Note on flags used for some tools

In the case of the 'ag' tool, we pass the '--no-affinity' flag
in order to prevent some error or warning.

In the case of the fd tool, we pass the '-H -I' flags to simulate the behaviour
of the find and locate or mlocate programs. Normally, 'fd' will skip hidden
files and any pattens in '.gitignore' files. These flags suppress this
behaviour to more closely match that of find, locate and mlocate.

## A pure Apples to Apples test

In order to not show any favorability to tools that might use extra threads
running on a multi-core system, we can restrict the docker run command to just
a single CPU.

```bash
$ docker run --rm --cpuset-cpus 0 -v ${DOMAIN}:/domain -v $SCRATCH}:/work edhowland/searchbench main.rs 10
```

In the above case, the flag '--cpuset-cpus 0' is passed to the docker run invocation.
Then locate and fdfind should be running on similar footing.

In my tests, this did not change the rankings.

## Changing the order of the search passes

When run normally, the scripts/bench.sh script runs the test in interleaved
mode. For each pass, every tool is run once before proceeding to the next
command. However, we can also run the same benchmark in serial mode. to do this,
we pass the '--entrypoint "./serialmark.sh" to the docker run command.


```bash
$ docker run --rm --entrypoint "./serialmark.sh" -v ${DOMAIN}:/domain -v $PSCRATCH}:/work edhowland/searchbench main.rs 10
```




## Debugging/Logging

You can activate logging information by passing the 'BENCH_LOG' variable set to 1
in the docker run command flags:

```bash

```bash
$ docker run --rm -it --entrypoint bash  -v ${DOMAIN}:/domain -v ${SCRATCH}:/work edhowland/searchbench
```
$ docker run --rm --env BENCH_LOG=1 -v ${DOMAIN}:/domain -v ${SCRATCH}:/work edhowland/searchbench main.rs 1
```

In the above case we are just running a single pass. The log file be written
to '/tmp/bench.log'. This file might be write-protected. It can be removed
by 'rm -f /tmp/bench.log' when no longer needed.

### Poking around inside the container to manually test some stuff

You can  override the default entry point of the container with the  '--entrypoint bash'
flag to the docker run command.




In the above case we do not pass any arguments to the command.


## Analysis

If you clone this repository from the GitHub link above, you will get several
shell scripts to automate the above docker run commands These are all files
beginning with 'docker.'. They set DOMAIN and SCRATCH environment variables
to the following default values. Note: override them by setting yourself first.

- DOMAIN=${HOME}
- SCRATCH=${PWD}

### Example run using main script:

```bash
$ docker.run main.rs 10 >passes-10.csv
```

### Using Sqlite3 to perform some analysis

In addition, you get some Sqlite3 .sql files to help you analyze the CSV output.

There are 2 tables  created by the benchmark.schema file.

- runs : Raw contents of the CSV input file
- averages :  Computed averages of all times grouped by command across all passes.


You can run the analyze.sh script with the CSV file name and the database file name
to get a ranked result of the averages across all passes.

```bash
$ ./analyze.sh passes-10.csv passes-10.db
...
```
