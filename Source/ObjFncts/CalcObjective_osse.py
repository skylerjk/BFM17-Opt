import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset
import sys

# List of State Variables of interest
State_Variables = ['P2l','P2c','P2n','P2p','Z5c','Z5n','Z5p','R1c','R1n','R1p','R6c','R6n','R6p','N1p','N3n','N4n','O2o']

depth = 150
Num_Days = 30
Sim_Days = 30
Num_SVar = len(State_Variables)

# Control Flag for Normalization
Flag_Norm = eval(sys.argv[1])

# Location of BFM17-POM1D results
NC_Ref_File_Location = 'bfm17_pom1d-ref.nc'
NC_Tst_File_Location = 'bfm17_pom1d.nc'

# Load the set of data
NC_Ref_Data = Dataset(NC_Ref_File_Location)
NC_Tst_Data = Dataset(NC_Tst_File_Location)

Temp_Ref = np.zeros([Num_SVar,Sim_Days,depth])
Temp_Tst = np.zeros([Num_SVar,Sim_Days,depth])

BGC_Ref_Data = np.zeros([Num_SVar,depth,Num_Days])
BGC_Tst_Data = np.zeros([Num_SVar,depth,Num_Days])

for i, var in enumerate(State_Variables):
    # Load Reference Data
    Temp_Ref[i,:,:] = NC_Ref_Data[var][:]
    
    # Load Test Data
    Temp_Tst[i,:,:] = NC_Tst_Data[var][:]
    
    # Assign data to array for analysis
    BGC_Ref_Data[i,:,:] = Temp_Ref[i,:,:].transpose()
    BGC_Tst_Data[i,:,:] = Temp_Tst[i,:,:].transpose()

N = float(Num_Days*depth)

# Calculate the RMSD in the field of each state variable
RMSD = np.sqrt(np.sum(np.sum((BGC_Tst_Data - BGC_Ref_Data)**2, axis = 2), axis = 1)/N)

if Flag_Norm:
    # Load normalization values from nominal case
    NormVals = np.load('../NormVals.npy')

    # Sum normalized RMSD values to calculate objective function
    obj = np.sum(RMSD/NormVals)

else:
    # Sum RMSD values to calculate objective function
    obj = np.sum(RMSD)

# How to output data
ofile = open('result.out','w')
ofile.write(repr(obj))
ofile.close()
