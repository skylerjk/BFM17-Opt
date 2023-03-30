#!/bin/bash

#PBS -N RunName
#PBS -A ProjCode
#PBS -q economy
#PBS -l walltime=12:00:00
#PBS -l select=01:ncpus=36:mpiprocs=36

module purge
module load gnu
module load openmpi
module load netcdf

module load conda
conda activate OptEnv

PATH=$PATH:/glade/u/home/skylerk/dakota/bin/
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NETCDF/lib

python3 RunOpt.py
