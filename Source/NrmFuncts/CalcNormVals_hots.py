import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset
import sys

# Control Flag for Normalization
NormVal = sys.argv[1]

depth = 150
Num_Days = 360
Num_Fld = 10

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Loading observational data from .npy files                               # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
Obs_Ref_Data = np.zeros([Num_Fld,12,depth])

# Chlorophyll Data
Temp = np.load('../ObsHOTS/Chla_1yr_HOTS.npy')
Obs_Ref_Data[0,:,:] = Temp[0:150,:].transpose()
Temp = None
# Oxygen Data
Temp = np.load('../ObsHOTS/Oxy_1yr_HOTS.npy')
Obs_Ref_Data[1,:,:] = Temp[0:150,:].transpose()
Temp = None
# Nitrate Data
Temp = np.load('../ObsHOTS/Nit_1yr_HOTS.npy')
Obs_Ref_Data[2,:,:] = Temp[0:150,:].transpose()
Temp = None
# Phosphate Data
Temp = np.load('../ObsHOTS/Phs_1yr_HOTS.npy')
Obs_Ref_Data[3,:,:] = Temp[0:150,:].transpose()
Temp = None
# Dissolved Organic Matter Data - Carbon
Temp = np.load('../ObsHOTS/DOC_1yr_HOTS.npy')
Obs_Ref_Data[4,:,:] = Temp[0:150,:].transpose()
Temp = None
# Dissolved Organic Matter Data - Nitrogen
Temp = np.load('../ObsHOTS/DON_1yr_HOTS.npy')
Obs_Ref_Data[5,:,:] = Temp[0:150,:].transpose()
Temp = None
# Dissolved Organic Matter Data - Phosphorous
Temp = np.load('../ObsHOTS/DOP_1yr_HOTS.npy')
Obs_Ref_Data[6,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Carbon
Temp = np.load('../ObsHOTS/POC_1yr_HOTS.npy')
Obs_Ref_Data[7,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Nitrogen
Temp = np.load('../ObsHOTS/PON_1yr_HOTS.npy')
Obs_Ref_Data[8,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Phosphorous
Temp = np.load('../ObsHOTS/POP_1yr_HOTS.npy')
Obs_Ref_Data[9,:,:] = Temp[0:150,:].transpose()
Temp = None

if NormVal == 'rSTD':

    rSTD = np.zeros(Num_Fld)
    # Calculating the standard deviation each obs field
    for i in range(Num_Fld):
        rSTD[i] = np.std(Obs_Ref_Data[i,:,:])


    NVals = np.copy(rSTD)

elif NormVal == 'iRMSD':
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
    # Dissolved Organic Matter - Carbon
    Temp[4,:,:] = NC_Data['R1c'][:]
    # Dissolved Organic Matter - Nitrogen
    Temp[5,:,:] = NC_Data['R1n'][:]
    # Dissolved Organic Matter - Phosphorous
    Temp[6,:,:] = NC_Data['R1p'][:]
    # Total Organic Particulate Matter Data - Carbon
    Temp[7,:,:] = NC_Data['R6c'][:] + NC_Data['P2c'][:] + NC_Data['Z5c'][:]
    # Total Organic Particulate Matter Data - Nitrogen
    Temp[8,:,:] = NC_Data['R6n'][:] + NC_Data['P2n'][:] + NC_Data['Z5n'][:]
    # Total Organic Particulate Matter Data - Phosphorous
    Temp[9,:,:] = NC_Data['R6p'][:] + NC_Data['P2p'][:] + NC_Data['Z5p'][:]

    #
    BGC_Raw_Data = np.zeros([Num_Fld,360,depth])
    BGC_Avg_Data = np.zeros([Num_Fld,12,depth])

    for i in range(Num_Fld):
        # Limit model output data to final year of 3 year simulation
        BGC_Raw_Data[i,:,:] = Temp[i,-360:,:]

    # Calculate Monthly Averages for comparison to obs data
    for f in range(Num_Fld):
        for m in range(12):
            BGC_Avg_Data[f,m,:] = np.sum(BGC_Raw_Data[f, 30*m:30*(m+1),:], axis = 0)/30.

    # Number of Data Points
    N = 12.0*150.0
    # Calculate the RMSD in the field of each state variable
    RMSD = np.sqrt(np.sum(np.sum((BGC_Avg_Data - Obs_Ref_Data)**2, axis = 2), axis = 1)/N)

    NVals = np.copy(RMSD)

np.save('NormVals',NVals)
