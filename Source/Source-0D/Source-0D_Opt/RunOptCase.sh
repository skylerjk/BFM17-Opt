#!/bin/zsh
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# File: RunOptCase.#!/bin/sh
# Script to run the 0D BFM17 code
#
# June 2021 - Skyler Kern
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

InitRun=$1
PostRun=$2
NormObj=$3

echo '> > > Running Parameter Study < < <'

# Set the BFM Directory
export BFMDir="$(pwd)/src_dir"
export NETCDF="/usr/local/netcdf"

# Compile Standalone BFM17
cd $BFMDir/build
./bfm_configure.sh -gcd
cd ../..

if $InitRun; then
  cp $BFMDir/bin/bfm_standalone.x evl_dir/IEval
fi

if $PostRun; then
  cp $BFMDir/bin/bfm_standalone.x evl_dir/FEval
fi

if $InitRun; then
  cd evl_dir/IEval

  # Generate Namelists
  ./InitRunInterface.sh '0D'
  # Perform Initial Run of Model
  ./bfm_standalone.x

  # Run Analysis Script
  python3 CalcObjective.py

  # Go back to opt case directory
  cd ../../

  if $NormObj; then
    cp evl_dir/IEval/EvlResults.out opt_dir/Data/InitResults.out
  fi
fi

cd opt_dir/
# Move Executable
cp $BFMDir/bin/bfm_standalone.x .

# Run DAKOTA
time dakota -i dakota.in -o output.out -e error.err

# With Sequential Run
if $PostRun; then
  cd ../evl_dir

  # Write Best Parameters to new file
  OutFl=../opt_dir/output.out
  PrmFl=OptVals.txt

  Frst=`grep -n '<<<<< Best parameters          =' $OutFl | cut -d: -f1`
  Last=`grep -n '<<<<< Best objective function  =' $OutFl | cut -d: -f1`

  sed -n "$Frst,$Last p" $OutFl > $PrmFl
  sed -i '' 's/^ *//' $PrmFl

  cd FEval

  # Generate Namelists
  ./PostRunInterface.sh '0D'

  # Perform Optimized Run of Model
  ./bfm_standalone.x

  # Run Analysis Script
  python3 CalcObjective.py

fi
