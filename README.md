# Searchbench - Docker image for benchmarking search methods

## Abstract

This Docker container will benchmark 8 file/path search tools on a x86-64 Linux
system for a given filename. It will return its results in a CSV formatted to stdout.

## Running the searchbench tool:

```bash
$ docker run --rm -v ${HOME}:${HOME} -v $PWD}:/work edhowland/searchbench main.rs 10
```

The first mounted volume is the path you want to search in for the filename.
The second volume (both are required) is a scratch folder. You could /tmp for this.
Finally, we give the filename to search for, here: main.rs,  and the number of benchmark
passes, in this case 10.

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

- locate
- mlocate
- find
- fd (debian package: fdfind) : A find replacement written in Rust

### The matchers

- fgrep
- ack
- ag (Also known as the Silver Searcher)
- rg : A replacement for grep or ag written in Rust




