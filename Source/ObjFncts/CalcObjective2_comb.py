import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset
import sys

# Control Flag for Normalization
Flag_Norm = eval(sys.argv[1])

depth = 150
Num_Days = 360

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Loading BATS Data                                                        # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
Num_Fld_BATS = 8

# # Observational Data
BATS_Obs_Data = np.zeros([Num_Fld_BATS,12,depth])

# Chlorophyll Data
Temp = np.load('../ObsBATS/Chla_1yr_climatology.npy')
BATS_Obs_Data[0,:,:] = Temp[0:150,:].transpose()
Temp = None
# Oxygen Data
Temp = np.load('../ObsBATS/Oxy_1yr_climatology.npy')
BATS_Obs_Data[1,:,:] = Temp[0:150,:].transpose()
Temp = None
# Nitrate Data
Temp = np.load('../ObsBATS/Nitrate_1yr_climatology.npy')
BATS_Obs_Data[2,:,:] = Temp[0:150,:].transpose()
Temp = None
# Phosphate Data
Temp = np.load('../ObsBATS/Phos_1yr_climatology.npy')
BATS_Obs_Data[3,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Carbon
Temp = np.load('../ObsBATS/POC_1yr_climatology.npy')
BATS_Obs_Data[4,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Nitrogen
Temp = np.load('../ObsBATS/PON_1yr_climatology.npy')
BATS_Obs_Data[5,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Phosphorous
Temp = np.load('../ObsBATS/POP_1yr_climatology.npy')
BATS_Obs_Data[6,:,:] = Temp[0:150,:].transpose()
Temp = None
# Net Primary Production Data
Temp = np.load('../ObsBATS/NPP_1yr_climatology.npy')
BATS_Obs_Data[7,:,:] = Temp[0:150,:].transpose()
Temp = None

# Field Wieghting
Pi_BATS = np.array([ 1.0, 1.0, 1.0, 1.0, 1.0/3.0, 1.0/3.0, 1.0/3.0, 1.0])

# # Model Data # #

# Output DataFile
NC_File_BATS = 'bfm17_pom1d_bats.nc'
# Load the set of data
NC_Data_BATS = Dataset(NC_File_BATS)

Temp = np.zeros([Num_Fld_BATS,1080,depth])
BATS_Raw_Data = np.zeros([Num_Fld_BATS,360,depth])

# Chlorophyll Data
Temp[0,:,:] = NC_Data_BATS['P2l'][:]
# Oxygen Data
Temp[1,:,:] = NC_Data_BATS['O2o'][:]
# Nitrate Data
Temp[2,:,:] = NC_Data_BATS['N3n'][:]
# Phosphate Data
Temp[3,:,:] = NC_Data_BATS['N1p'][:]
# Total Organic Particulate Matter Data - Carbon
Temp[4,:,:] = NC_Data_BATS['R6c'][:] + NC_Data_BATS['P2c'][:] + NC_Data_BATS['Z5c'][:]
# Total Organic Particulate Matter Data - Nitrogen
Temp[5,:,:] = NC_Data_BATS['R6n'][:] + NC_Data_BATS['P2n'][:] + NC_Data_BATS['Z5n'][:]
# Total Organic Particulate Matter Data - Nitrogen
Temp[6,:,:] = NC_Data_BATS['R6p'][:] + NC_Data_BATS['P2p'][:] + NC_Data_BATS['Z5p'][:]
# Net Primary Production Data
Temp[7,:,:] = NC_Data_BATS['ruPTc'][:] - NC_Data_BATS['resPP'][:] - NC_Data_BATS['resZT'][:]

#
for i in range(Num_Fld_BATS):
    # Limit model output data to final year of 3 year simulation
    BATS_Raw_Data[i,:,:] = Temp[i,-360:,:]

    # NPP units have to be converted to compare to obs data
    if i == 7:
        BATS_Raw_Data[i,:,:] = BATS_Raw_Data[i,:,:]/12.0

Temp = None

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Loading HOTS Dataset                                                     # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
Num_Fld_HOTS = 10

# # Observational Data # #
HOTS_Obs_Data = np.zeros([Num_Fld_HOTS,12,depth])

# Chlorophyll Data
Temp = np.load('../ObsHOTS/Chla_1yr_HOTS.npy')
HOTS_Obs_Data[0,:,:] = Temp[0:150,:].transpose()
Temp = None
# Oxygen Data
Temp = np.load('../ObsHOTS/Oxy_1yr_HOTS.npy')
HOTS_Obs_Data[1,:,:] = Temp[0:150,:].transpose()
Temp = None
# Nitrate Data
Temp = np.load('../ObsHOTS/Nit_1yr_HOTS.npy')
HOTS_Obs_Data[2,:,:] = Temp[0:150,:].transpose()
Temp = None
# Phosphate Data
Temp = np.load('../ObsHOTS/Phs_1yr_HOTS.npy')
HOTS_Obs_Data[3,:,:] = Temp[0:150,:].transpose()
Temp = None
# Dissolved Organic Matter Data - Carbon
Temp = np.load('../ObsHOTS/DOC_1yr_HOTS.npy')
HOTS_Obs_Data[4,:,:] = Temp[0:150,:].transpose()
Temp = None
# Dissolved Organic Matter Data - Nitrogen
Temp = np.load('../ObsHOTS/DON_1yr_HOTS.npy')
HOTS_Obs_Data[5,:,:] = Temp[0:150,:].transpose()
Temp = None
# Dissolved Organic Matter Data - Phosphorous
Temp = np.load('../ObsHOTS/DOP_1yr_HOTS.npy')
HOTS_Obs_Data[6,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Carbon
Temp = np.load('../ObsHOTS/POC_1yr_HOTS.npy')
HOTS_Obs_Data[7,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Nitrogen
Temp = np.load('../ObsHOTS/PON_1yr_HOTS.npy')
HOTS_Obs_Data[8,:,:] = Temp[0:150,:].transpose()
Temp = None
# Total Organic Particulate Matter Data - Phosphorous
Temp = np.load('../ObsHOTS/POP_1yr_HOTS.npy')
HOTS_Obs_Data[9,:,:] = Temp[0:150,:].transpose()
Temp = None

# Field Wieghting
Pi_HOTS = np.array([ 1.0, 1.0, 1.0, 1.0, 1.0/3.0, 1.0/3.0, 1.0/3.0, 1.0/3.0, 1.0/3.0, 1.0/3.0])

# # Model Data # #

# Output DataFile
NC_File_HOTS = 'bfm17_pom1d_hots.nc'
# Load the set of data
NC_Data_HOTS = Dataset(NC_File_HOTS)

Temp = np.zeros([Num_Fld_HOTS,1080,depth])
HOTS_Raw_Data = np.zeros([Num_Fld_HOTS,360,depth])

# Chlorophyll Data
Temp[0,:,:] = NC_Data_HOTS['P2l'][:]
# Oxygen Data
Temp[1,:,:] = NC_Data_HOTS['O2o'][:]
# Nitrate Data
Temp[2,:,:] = NC_Data_HOTS['N3n'][:]
# Phosphate Data
Temp[3,:,:] = NC_Data_HOTS['N1p'][:]
# Dissolved Organic Matter - Carbon
Temp[4,:,:] = NC_Data_HOTS['R1c'][:]
# Dissolved Organic Matter - Nitrogen
Temp[5,:,:] = NC_Data_HOTS['R1n'][:]
# Dissolved Organic Matter - Phosphorous
Temp[6,:,:] = NC_Data_HOTS['R1p'][:]
# Total Organic Particulate Matter Data - Carbon
Temp[7,:,:] = NC_Data_HOTS['R6c'][:] + NC_Data_HOTS['P2c'][:] + NC_Data_HOTS['Z5c'][:]
# Total Organic Particulate Matter Data - Nitrogen
Temp[8,:,:] = NC_Data_HOTS['R6n'][:] + NC_Data_HOTS['P2n'][:] + NC_Data_HOTS['Z5n'][:]
# Total Organic Particulate Matter Data - Phosphorous
Temp[9,:,:] = NC_Data_HOTS['R6p'][:] + NC_Data_HOTS['P2p'][:] + NC_Data_HOTS['Z5p'][:]

#
for i in range(Num_Fld_HOTS):
    # Limit model output data to final year of 3 year simulation
    HOTS_Raw_Data[i,:,:] = Temp[i,-360:,:]

Temp = None

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Calculate the monthly averages from raw model data                       # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

BATS_Avg_Data = np.zeros([Num_Fld_BATS,12,depth])
HOTS_Avg_Data = np.zeros([Num_Fld_HOTS,12,depth])

# Calculate Monthly Averages for comparison to obs data
for f in range(Num_Fld_BATS):
    for m in range(12):
        BATS_Avg_Data[f,m,:] = np.sum(BATS_Raw_Data[f, 30*m:30*(m+1),:], axis = 0)/30.

for f in range(Num_Fld_HOTS):
    for m in range(12):
        HOTS_Avg_Data[f,m,:] = np.sum(HOTS_Raw_Data[f, 30*m:30*(m+1),:], axis = 0)/30.

# Number of Data Points
N = 12.0*150.0
# Calculate the RMSD in the field of each state variable
abDif_BATS = np.abs(BATS_Avg_Data - BATS_Obs_Data)
abDif_HOTS = np.abs(HOTS_Avg_Data - HOTS_Obs_Data)

FldSum_BATS = np.sum(np.sum(abDif_BATS, axis = 2), axis = 1)/N
FldSum_HOTS = np.sum(np.sum(abDif_HOTS, axis = 2), axis = 1)/N

FldSum = np.concatenate((FldSum_BATS,FldSum_HOTS))
Pi = np.concatenate((Pi_BATS,Pi_HOTS))

if Flag_Norm:
    ObsAvg_BATS = np.mean(BATS_Obs_Data, axis = (1, 2))
    ObsAvg_HOTS = np.mean(HOTS_Obs_Data, axis = (1, 2))

    ObsAvg = np.concatenate((ObsAvg_BATS,ObsAvg_HOTS))
    # Sum normalized RMSD values to calculate objective function
    obj = np.sum(Pi*FldSum/ObsAvg)

else:
    # Sum RMSD values to calculate objective function
    obj = np.sum(Pi*FldSum)

# How to output data
ofile = open('result.out','w')
ofile.write(repr(obj))
ofile.close()
