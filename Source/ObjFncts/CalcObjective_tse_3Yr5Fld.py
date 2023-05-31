import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset
import sys

# List of State Variables of interest
State_Variables = ['P2l','O2o','N3n','N1p','R1n','P2n','Z5n']

# Field Wieghting
Pi = np.array([ 1.0, 1.0, 1.0, 1.0, 1.0])

depth = 150
Num_Days = 360
Sim_Days = 1080
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

BGC_Ref_Avg = np.zeros([Num_SVar,depth,12])
BGC_Tst_Avg = np.zeros([Num_SVar,depth,12])

BGC_Ref_Fnl = np.zeros([5,depth,12])
BGC_Tst_Fnl = np.zeros([5,depth,12])

for i, var in enumerate(State_Variables):
    # Load Reference Data - only final year of model data
    Temp_Ref[i,:,:] = NC_Ref_Data[var][:]
    BGC_Ref_Data[i,:,:] = Temp_Ref[i,-360:,:].transpose()
    
    # Load Test Data - only final year of model data
    Temp_Tst[i,:,:] = NC_Tst_Data[var][:]
    BGC_Tst_Data[i,:,:] = Temp_Tst[i,-360:,:].transpose()

# Calculate Monthly Averages for data comparison - ref vs. test
for sv in range(Num_SVar):
    for m in range(12):
        BGC_Ref_Avg[sv,:,m] = np.sum(BGC_Ref_Data[sv, :, 30*m:30*(m+1)], axis = 1)/30.
        BGC_Tst_Avg[sv,:,m] = np.sum(BGC_Tst_Data[sv, :, 30*m:30*(m+1)], axis = 1)/30.

for fld in range(5):
    if fld < 4:
        BGC_Ref_Fnl[fld,:,:] = BGC_Ref_Avg[fld,:,:]
        BGC_Tst_Fnl[fld,:,:] = BGC_Tst_Avg[fld,:,:]
    else:
        BGC_Ref_Fnl[fld,:,:] = BGC_Ref_Avg[4,:,:] + BGC_Ref_Avg[5,:,:] + BGC_Ref_Avg[6,:,:]
        BGC_Tst_Fnl[fld,:,:] = BGC_Tst_Avg[4,:,:] + BGC_Tst_Avg[5,:,:] + BGC_Tst_Avg[6,:,:]

N = float(12*depth)

# Calculate the RMSD in the field of each state variable
RMSD = np.sqrt(np.sum(np.sum((BGC_Tst_Fnl - BGC_Ref_Fnl)**2, axis = 2), axis = 1)/N)

if Flag_Norm:
    # Load normalization values from nominal case
    NormVals = np.load('../NormVals.npy')

    # Sum normalized RMSD values to calculate objective function
    obj = np.sum(Pi*(RMSD/NVals))

else:
    # Sum RMSD values to calculate objective function
    obj = np.sum(Pi*RMSD)

# How to output data
ofile = open('result.out','w')
ofile.write(repr(obj))
ofile.close()