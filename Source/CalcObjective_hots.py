import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset
import sys

# Control Flag for Normalization
Flag_Norm = eval(sys.argv[1])

depth = 150
Num_Days = 360
Num_Fld = 6

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Loading observational data from .npy files                               # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
Obs_Ref_Data = np.zeros([Num_Fld,12,depth])

# Chlorophyll Data
Temp = np.load('../ObsBATS/Chla_1yr_climatology.npy')
Obs_Ref_Data[0,:,:] = Temp[0:150,:].transpose()
Temp = None
# Oxygen Data
Temp = np.load('../ObsBATS/Oxy_1yr_climatology.npy')
Obs_Ref_Data[1,:,:] = Temp[0:150,:].transpose()
Temp = None
# Nitrate Data
Temp = np.load('../ObsBATS/Nitrate_1yr_climatology.npy')
Obs_Ref_Data[2,:,:] = Temp[0:150,:].transpose()
Temp = None
# Phosphate Data
Temp = np.load('../ObsBATS/Phos_1yr_climatology.npy')
Obs_Ref_Data[3,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data
Temp = np.load('../ObsBATS/PON_1yr_climatology.npy')
Obs_Ref_Data[4,:,:] = Temp[0:150,:].transpose()
Temp = None
# Net Primary Production Data
Temp = np.load('../ObsBATS/NPP_1yr_climatology.npy')
Obs_Ref_Data[5,:,:] = Temp[0:150,:].transpose()
Temp = None

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Loading model data from output file *.nc                                 # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Output DataFile
NC_File_Location = 'bfm17_pom1d.nc'
# Load the set of data
NC_Data = Dataset(NC_File_Location)

Temp = np.zeros([Num_Fld,1080,depth])

# Chlorophyll Data
Temp[0,:,:] = NC_Data['P2l'][:]
# Oxygen Data
Temp[1,:,:] = NC_Data['O2o'][:]
# Nitrate Data
Temp[2,:,:] = NC_Data['N3n'][:]
# Phosphate Data
Temp[3,:,:] = NC_Data['N1p'][:]
# Total Organic Particulate Matter Data
Temp[4,:,:] = NC_Data['R6n'][:] + NC_Data['P2n'][:] + NC_Data['Z5n'][:]
# Net Primary Production Data
Temp[5,:,:] = NC_Data['ruPTc'][:] - NC_Data['resPP'][:] - NC_Data['resZT'][:]

#
BGC_Raw_Data = np.zeros([Num_Fld,360,depth])
BGC_Avg_Data = np.zeros([Num_Fld,12,depth])

for i in range(Num_Fld):
    # Limit model output data to final year of 3 year simulation
    BGC_Raw_Data[i,:,:] = Temp[i,-360:,:]

    # NPP units have to be converted to compare to obs data
    if i == 5:
        BGC_Raw_Data[i,:,:] = BGC_Raw_Data[i,:,:]/12.0

# Calculate Monthly Averages for comparison to obs data
for f in range(Num_Fld):
    for m in range(12):
        BGC_Avg_Data[f,m,:] = np.sum(BGC_Raw_Data[f, 30*m:30*(m+1),:], axis = 0)/30.

# Number of Data Points
N = 12.0*150.0
# Calculate the RMSD in the field of each state variable
RMSD = np.sqrt(np.sum(np.sum((BGC_Avg_Data - Obs_Ref_Data)**2, axis = 2), axis = 1)/N)

if Flag_Norm:
    STD = np.zeros(Num_Fld)

    # Calculating the standard deviation each obs field
    for i in range(Num_Fld):
        STD[i] = np.std(Obs_Ref_Data[i,:,:])

    # Sum normalized RMSD values to calculate objective function
    obj = np.sum(RMSD/STD)

else:
    # Sum RMSD values to calculate objective function
    obj = np.sum(RMSD)

# How to output data
ofile = open('result.out','w')
ofile.write(repr(obj))
ofile.close()