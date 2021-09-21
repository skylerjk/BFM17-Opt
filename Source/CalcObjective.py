import numpy as np
import matplotlib.pyplot as plt
from netCDF4 import Dataset

State_Variables = ['P2l','P2c','P2n','P2p','Z5c','Z5n','Z5p','R1c','R1n','R1p','R6c','R6n','R6p','N1p','N3n','N4n','O2o']

depth = 150
Num_Days = 30
Num_SVar = len(State_Variables)

# Location of BFM17-POM1D results
NC_Ref_File_Location = 'bfm17_pom1d-ref.nc'
NC_Tst_File_Location = 'bfm17_pom1d.nc'

# Load the set of data
NC_Ref_Data = Dataset(NC_Ref_File_Location)
NC_Tst_Data = Dataset(NC_Tst_File_Location)

# Temp_Ref = np.zeros([Num_SVar,Num_Days,depth])
# Temp_Tst = np.zeros([Num_SVar,num_days,depth])

BGC_Ref_Data = np.zeros([Num_SVar,Num_Days,depth])
BGC_Tst_Data = np.zeros([Num_SVar,Num_Days,depth])

for i, var in enumerate(State_Variables):
    # Temp_Ref[i,:,:] = NC_Ref_Data[var][:]
    # BGC_Ref_Data[i,:,:] = Temp_BGC_Data[i,-360:,:].transpose()

    # Temp_Tst[i,:,:] = NC_Tst_Data[var][:]
    # BGC_Tst_Data[i,:,:] = Temp_BGC_Data[i,-360:,:].transpose()

    BGC_Ref_Data[i,:,:] = NC_Ref_Data[var][:]
    BGC_Tst_Data[i,:,:] = NC_Tst_Data[var][:]

N = float(Num_Days*depth)
RMSD = np.sqrt(np.sum(np.sum((BGC_Tst_Data - BGC_Ref_Data)**2, axis = 2), axis = 1)/N)

RMSD2 = np.zeros(Num_SVar)
for i in range(Num_SVar):
    RMSD2[i] = np.sqrt(np.sum((BGC_Tst_Data[i,:,:] - BGC_Ref_Data[i,:,:])**2)/N)

obj = np.sum(RMSD)
obj2 = np.sum(RMSD2)

print(obj)
print(obj2)

ofile = open('result.out','w')
ofile.write(repr(obj))
ofile.close()
