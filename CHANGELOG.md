# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]


## Release 0.1 2020-09-05

### Update README.md to warn about not using any mounted network shares


### Logging not working


Filename was incorrect in scripts/bench_log.sh

### Log the exit status of each command pass

When running in logging mode, the exit status of each command is written to the log file.


### Update README.md with Logging command


### Exit with 2 if no pattern can be found in initialization script

If the benchmark is to be run against a file that is not found in the mounted 
volumes, then the script exits early with exit status 2 and both logs and reports
to stderr that it could not be found and is exitting

### Log the first result found of the search string for the first pass of each command


### Make new entrypoint for serial usage vs interleaved

This entry point is scripts/serialmark.sh


### Fixed fd command no finding any results

Changed global search context to root : /

### Fixed ### fgrep not finding any results

fgrep must take glob, not regex for filename pattern.