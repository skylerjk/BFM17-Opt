#!/bin/zsh
# Script to define local paths, compile and execute BFM_POM 1D,
# change restart files names

export BFMDIR="$(pwd)"
export NETCDF="/usr/local/netcdf"
export BFMDIR_RUN="$BFMDIR/bfm_run"

cd $BFMDIR/build

./bfm_configure.sh -gdc -p BFM_POM BFM17

cd $BFMDIR
