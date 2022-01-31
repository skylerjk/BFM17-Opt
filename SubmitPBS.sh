#!/bin/bash

#PBS -N BFM17-OptRun
#PBS -A UCUB0079
#PBS -q regular
#PBS -l walltime=12:00:00
#PBS -l select=01:ncpus=29:mpiprocs=32

module purge
module load gnu
module load openmpi
module load netcdf

module load conda
conda activate OptEnv

PATH=$PATH:/glade/u/home/skylerk/dakota/bin/
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NETCDF/lib

python3 RunOpt.py
