# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
# Script : CalcNormVals.py                                                #
#                                                                         #
# Description :                                                           #
# This script produces a numpy binary of 17 values for the 17 state       #
# variable fields which is used to normalize the root mean squared error  #
# as part of the objective function during an optimization performed as   #
# part of a parameter estimation routine.                                 #
#                                                                         #
# Developed :                                                             #
# Skyler Kern - October 20, 2021                                          #
#                                                                         #
# Institution :                                                           #
# This was created in support of research done in the Turbulence and      #
# Energy Systems Laboratory (TESLa) from the Paul M. Rady Department of   #
# Mechanical Engineering at the University of Colorado Boulder.           #
#                                                                         #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

# Import modules
import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset
import sys

# List of State Variables of interest
State_Variables = ['P2l','P2c','P2n','P2p','Z5c','Z5n','Z5p','R1c','R1n','R1p','R6c','R6n','R6p','N1p','N3n','N4n','O2o']

depth = 150
# Num_Days = 360
# Sim_Days = 1080
Num_Days = 30
Sim_Days = 30
Num_SVar = len(State_Variables)

# Location of BFM17-POM1D results
NC_File_Location = 'bfm17_pom1d.nc'

# Load the set of data
NC_Data = Dataset(NC_File_Location)

Temp = np.zeros([Num_SVar,Sim_Days,depth])
BGC_Data = np.zeros([Num_SVar,depth,Num_Days])

# Load data from BGC model
for i, var in enumerate(State_Variables):
    # Load data for state variable var
    Temp[i,:,:] = NC_Data[var][:]
    # If using 3 year simulation
    # BGC_Data[i,:,:] = Temp[i,-360:,:].transpose()

    # Organizing BGC model data into depth - time
    BGC_Data[i,:,:] = Temp[i,:,:].transpose()

# Get max Value for each field
# MaxVal = np.max(np.max(BGC_Data,2),1)

# Get the standard deviation for each field
STD = np.zeros(17)
for ii in range(Num_SVar):
    STD[ii] = np.std(BGC_Data[ii,:,:])

# Save values for normalization during objective function calculations
# np.save("NormVals",MaxVal)
np.save("NormVals",STD)
