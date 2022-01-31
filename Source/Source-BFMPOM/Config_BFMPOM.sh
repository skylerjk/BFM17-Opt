#!/bin/zsh
# Script to define local paths, compile and execute BFM_POM 1D,
# change restart files names

export BFMDIR="$(pwd)"
export BFMDIR_RUN="$BFMDIR/bfm_run"

# Include to run locally
# export NETCDF="/usr/local/netcdf"

cd $BFMDIR/build

./bfm_configure.sh -gdc -p BFM_POM BFM17

cd $BFMDIR
