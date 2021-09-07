#!/bin/zsh
# Script to define local paths, compile and execute BFM_POM 1D,
# change restart files names

InitRun=$1
PostRun=$2
NormObj=$3

export BFMDIR="$(pwd)/src_dir"
export NETCDF="/usr/local/netcdf"
export BFMDIR_RUN="$BFMDIR/bfm_run"

mkdir $BFMDIR_RUN/bfm17_pom1d
# cd $BFMDIR_RUN/bfm17_pom1d
# rm -rf  pom.exe pom_restart* bfm_restart*

cd $BFMDIR/build

./bfm_configure.sh -gdc -p BFM_POM BFM17

cd $BFMDIR_RUN
rm -r bfm17_pom1d
cd ../..

if $InitRun; then
  cp $BFMDIR/bin/pom.exe evl_dir/IEval
fi

if $PostRun; then
  cp $BFMDIR/bin/pom.exe evl_dir/FEval
fi

if $InitRun; then
  cd evl_dir/IEval

  # Generate Namelists
  ./InitRunInterface.sh '1D'
  # Perform Initial Run of Model
  ./pom.exe

  # Run Analysis Script
  python3 CalcObjective.py

  # Go back to opt case directory
  cd ../../

  if $NormObj; then
    cp evl_dir/IEval/EvlResults.out opt_dir/Data/InitResults.out
  fi
fi

cd opt_dir

# rm pom.exe bfmpom_opt.dat bfmpom_opt.out bfmpom_opt.err dakota.rst
cp $BFMDIR/bin/pom.exe .

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
  ./PostRunInterface.sh '1D'

  # Perform Optimized Run of Model
  ./pom.exe

  # Run Analysis Script
  python3 CalcObjective.py

fi
