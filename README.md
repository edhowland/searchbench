# Searchbench - Docker image for benchmarking search methods

## Current Docker tag

edhowland/searchbench:0.2

This Docker container will benchmark 8 file/path search tools on a x86-64 Linux
system for a given filename. It will return its results in a CSV formatted to stdout.

## Dockerfile

[Dockerfile](https://github.com/edhowland/searchbench/blob/master/Dockerfile "Dockerfile used to build this image")


## Source on GitHub

The sources for this image can be found over at <https://github.com/edhowland/searchbench>

## Running the searchbench tool:

There are 2 mountpoints needed for the container to run the benchmark.

Note: **Make sure neither of these mount points are attached to a folder
containing any mounted network shares!**

- The top level directory wherein you want to search for the passed in file. Volume is read-only
- A scratchpad directory where searchbench will create some temporary files like log files and the'dirs+files.lst'

```bash
$ docker run --rm -v ${HOME}:${HOME} -v /tmp:/work edhowland/searchbench main.rs 10
```

Again note: ** Make sure '-v ${HOME}:${HOME}' does not contain any mounted network shares**.

Finally, we give the filename to search for, here: main.rs,  and the number of benchmark
passes, in this case 10.

Note: Any files generated in the scratchpad folder mounted to /work in the container
might be write-protected. They can be removed with 'rm -f dirs+files.lst bench.log'


## Output format

The output written to  stdout is in comma separated value (CSV) format.
of raw passes for each tool benchmarked. The timer used is the GNU time program.

### Fields

1. Pass number: The number of this pass run.
2. Command : The name of the command used in the timing test.
3. The name of the file searched for.
4. The real time
5. The user time
6. The sys time

### Example

This example searched for the file 'main.rs' and ran 2 passes of the benchmark.

```
1,locate,main.rs,0.093,0.085,0.008
1,mlocate,main.rs,0.088,0.084,0.004
1,fn.find,main.rs,1.080,0.430,0.642
1,fdfind,main.rs,0.003,0.004,0.000
1,fn.fgrep,main\.rs,0.039,0.031,0.008
1,fn.ack,main\.rs,0.431,0.407,0.024
1,fn.ag,main\.rs,0.127,0.122,0.005
1,fn.rg,main\.rs,0.019,0.018,0.000
2,locate,main.rs,0.093,0.089,0.004
2,mlocate,main.rs,0.089,0.089,0.000
2,fn.find,main.rs,1.075,0.462,0.609
2,fdfind,main.rs,0.003,0.004,0.000
2,fn.fgrep,main\.rs,0.041,0.037,0.004
2,fn.ack,main\.rs,0.432,0.408,0.024
2,fn.ag,main\.rs,0.124,0.117,0.008
2,fn.rg,main\.rs,0.020,0.012,0.008
```


## The tools used

### The searchers

These tools recurse the directory tree and find a matching filename or pattern.
In the case of locate and mlocate, they rely on the tool 'updatedb' to have been
run beforehand, say, in a cron job. The searchbench script runs this first.

- locate
- mlocate
- find
- fd (debian package: fdfind) : A find replacement written in Rust

### The matchers

These tools search against a list of paths and filenames generated with the
following command in the bench script:

```
find / > /work/dirs+files.lst
```

Once the searchbench tool has been run, this file will be created in  whichever
folder you mounted to /work  inside the container. E.g. $PWD.

All the following tools are grep-alike in their usage.

- fgrep
- ack
- ag (Also known as the Silver Searcher)
- rg : A replacement for grep or ag written in Rust

## A pure Apples to Apples test

In order to not show any favorability to tools that might use extra threads
running on a multi-core system, we can restrict the docker run command to just
a single CPU.

```bash
$ docker run --rm --cpuset-cpus 1 -v ${HOME}:${HOME} -v $PWD}:/work edhowland/searchbench main.rs 10
```

In the above case, the flag '--cpuset-cpus 1' is passed to the docker run invocation.
Then locate and fdfind should be running on similar footing.

In my tests, this did not change the rankings.






## Debugging/Logging

You can activate logging information by passing the 'BENCH_LOG' variable set to 1
in the docker run command flags:

```bash

```bash
$ docker run --rm -it --entrypoint bash  -v ${HOME}:${HOME} -v /tmp:/work edhowland/searchbench
```
$ docker run --rm --env BENCH_LOG=1 -v ${HOME}:${HOME} -v /tmp:/work edhowland/searchbench main.rs 1
```

In the above case we are just running a single pass. The log file be written
to '/tmp/bench.log'. This file might be write-protected. It can be removed
by 'rm -f /tmp/bench.log' when no longer needed.

### Poking around inside the container to manually test some stuff

You can  override the default entry point of the container with the  '--entrypoint bash'
flag to the docker run command.




In the above case we do not pass any arguments to the command.
