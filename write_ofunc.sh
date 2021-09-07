#!/bin/zsh

# Head Directory Name
Dir=$1; shift
# BFMCASE: Switch between 0D and 1D cases
BFMCase=$1; shift
# InitRun: Switch for if normalization data was calculated
NormObj=$1; shift
# Writing Script for Initial Run, instead of optimiation
RefCalc=$1; shift
# State Variable Switches
obj_bl=( $@ )
# Relative Path to Ref Data
DatDir='../Data'

# Count number of state variables being optimized
cnt=0
for i in {1..${#obj_bl[@]}}
do
  if $obj_bl[i]; then
    cnt=$(( cnt+1 ))
  fi
done

# Set pieces of code that change between models cases
case $BFMCase in
  0D )
      # Data Shape
      sfx=':]'
      # File Prefix
      fpfx='BFM_standalone_pelagic'
      # File Suffix
      fsfx=''


    ;;
  1D )
      # Data Shape
      sfx=':,:]'
      # File Prefix
      fpfx='bfm17_pom1d'

      # Setting File Suffix
      SIM='30D'
      case $SIM in
        30D )
            fsfx=''
            nt=30
          ;;
        1Yr )
            fsfx='-1YrSim'
            nt=360
          ;;
        3Yr )
            fsfx='-3YrSim'
            nt=1080

          ;;
      esac

    ;;
esac

# Write descript of objective function calculator
/bin/cat << EOF >$Dir/CalcObjective.py
# Objective Function Calculator
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script is generated to by write_ofunc.sh to interpret the BFM17
# results. That is it calculates the objective function values based on the
# user defined fields of interest.

import numpy as np
from netCDF4 import Dataset

print('> > > Evaluating Objective Function')

# Location of Reference Data
RefFile = '$DatDir/$fpfx-ref$fsfx.nc'
# Location of Simulation Data
SimFile = '$fpfx.nc'

# Load NC Data Files
RefDS = Dataset(RefFile)
SimDS = Dataset(SimFile)

EOF

if $NormObj; then
  if ! $RefCalc; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Load Normalization Data
ifile=open('$DatDir/InitResults.out')
RMSD_ref = np.loadtxt(ifile)
ifile.close()

EOF
  fi
fi

if [[ $BFMCase = '0D' ]]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Empty Data Arrays
RefTemp = np.zeros([$cnt,1096])
SimTemp = np.zeros([$cnt,1096])

EOF
elif [[ $BFMCase = '1D' ]]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Empty Data Arrays
RefTemp = np.zeros([$cnt,150,$nt])
SimTemp = np.zeros([$cnt,150,$nt])

EOF
fi

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Inserting State Variable Read Statements                                     #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Starting Index
ind=0

# Adding Pchl is obj_bl is true
if $obj_bl[1]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Phytoplankton - Cholorophyll
RefTemp[$ind,$sfx = np.transpose(RefDS['P2l'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['P2l'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[2]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Phytoplankton - Carbon
RefTemp[$ind,$sfx = np.transpose(RefDS['P2c'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['P2c'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[3]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Phytoplankton - Nitrogen
RefTemp[$ind,$sfx = np.transpose(RefDS['P2n'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['P2n'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[4]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Phytoplankton - Phosphorous
RefTemp[$ind,$sfx = np.transpose(RefDS['P2p'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['P2p'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[5]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Zooplankton - Carbon
RefTemp[$ind,$sfx = np.transpose(RefDS['Z5c'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['Z5c'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[6]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Zooplankton - Nitrogen
RefTemp[$ind,$sfx = np.transpose(RefDS['Z5n'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['Z5n'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[7]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Zooplankton - Phosphorous
RefTemp[$ind,$sfx = np.transpose(RefDS['Z5p'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['Z5p'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[8]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Labile DOM - Carbon
RefTemp[$ind,$sfx = np.transpose(RefDS['R1c'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['R1c'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[9]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Labile DOM - Nitrogen
RefTemp[$ind,$sfx = np.transpose(RefDS['R1n'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['R1n'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[10]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Labile DOM - Phosphorous
RefTemp[$ind,$sfx = np.transpose(RefDS['R1p'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['R1p'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[11]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Labile POM - Carbon
RefTemp[$ind,$sfx = np.transpose(RefDS['R6c'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['R6c'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[12]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Labile POM - Nitrogen
RefTemp[$ind,$sfx = np.transpose(RefDS['R6n'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['R6n'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[13]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Labile POM - Phosphorous
RefTemp[$ind,$sfx = np.transpose(RefDS['R6p'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['R6p'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[14]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Phosphate
RefTemp[$ind,$sfx = np.transpose(RefDS['N1p'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['N1p'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[15]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Nitrate
RefTemp[$ind,$sfx = np.transpose(RefDS['N3n'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['N3n'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[16]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Ammonia
RefTemp[$ind,$sfx = np.transpose(RefDS['N4n'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['N4n'][:])
EOF
  ind=$(( $ind+1 ))
fi

if $obj_bl[17]; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Oxygen
RefTemp[$ind,$sfx = np.transpose(RefDS['O2o'][:])
SimTemp[$ind,$sfx = np.transpose(SimDS['O2o'][:])
EOF
  ind=$(( $ind+1 ))
fi

# Select Data from Total Loaded Data to use in calculation of Obj function
if [[ $BFMCase = '0D' ]]; then
/bin/cat << EOF >>$Dir/CalcObjective.py

# Limit Data to final year
RefData = RefTemp[:,-365:]; SimData = SimTemp[:,-365:]
N = 365.

RMSD = np.sqrt(np.sum((SimData - RefData)**2,axis = 1)/N)

EOF
elif [[ $BFMCase = '1D' ]]; then
/bin/cat << EOF >>$Dir/CalcObjective.py

# Use full time series worth of data
RefData = RefTemp; SimData = SimTemp
N = 4500.

RMSD = np.sqrt(np.sum(np.sum((SimData - RefData)**2,axis = 2),axis = 1)/N)

EOF
fi

# In the case that this is being used to calculate the objective function for
# the initial run, the values have to be saved to a .mat file.
if $RefCalc ; then
/bin/cat << EOF >>$Dir/CalcObjective.py
ofile = open('EvlResults.out','w')
np.savetxt(ofile,RMSD)
ofile.close()
EOF

else
  if $NormObj ; then
/bin/cat << EOF >>$Dir/CalcObjective.py
# Calculate the Objective Function
obj = np.sum(RMSD/RMSD_ref)

# obj = np.sum(np.log10(RMSD/RMSD_ref))
# obj = np.log10(np.sum(RMSD/RMSD_ref))

# Write Objective Function Evaluation to return file
ofile = open('result.out','w')
ofile.write(repr(obj))
ofile.close()
EOF

  else
/bin/cat << EOF >>$Dir/CalcObjective.py
# Calculate the Objective Function
obj = np.sum(RMSD)

# obj = np.sum(np.log10(RMSD))
# obj = np.log10(np.sum(RMSD))

# Write Objective Function Evaluation to return file
ofile = open('result.out','w')
ofile.write(repr(obj))
ofile.close()
EOF
  fi
fi
