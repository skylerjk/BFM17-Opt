#!/bin/bash

module purge
module load gnu
module load openmpi
module load netcdf

module load conda
conda activate OptEnv

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NETCDF/lib

CASE='bats'
OPTW='True'
NORM='True'

HOME="$(pwd)"

for SC in {0..9}
do
  cd OptRun-SampleSet$SC
  
  # Remove Previous Run
  # rm -r OptRun
  # Update Run File
  # rm RunSol.py
  # cp ../RunSol.py .

  # Run Opt Case
  python RunSol.py $CASE $OPTW
  cd OptRun
  python CalcObjective.py $NORM

  cd $HOME

done
