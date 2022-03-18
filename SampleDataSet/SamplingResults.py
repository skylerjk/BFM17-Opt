import numpy as np

DataDir = '../../AnalysisVPpr/SRuns/Smpl-51Prm-OSSE-NrmWRMSD/'
FileName = 'PEOutput.dat'

PrmData = np.zeros([15000,51])
ObjData = np.zeros(15000)

with open(DataDir + FileName) as DataFile:
    for i, line in enumerate(DataFile):
        if i > 0:
            temp = line.split()
            PrmData[i-1,:]  = temp[2:53]
            ObjData[i-1] = temp[53]

index = np.where(ObjData == ObjData.min())
PrmVal_best = np.squeeze(PrmData[index[0],:])

np.save("OSSE_PrmVals_best", PrmVal_best)
