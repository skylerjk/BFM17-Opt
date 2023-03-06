import numpy as np

DataDir = '../SRuns/Smpl-51Prm-Comb-NrmWrSTD-1Chl-NewVels/'
FileName = 'PEOutput.dat'

RRFile = open(DataDir + 'RefRun/result.out')
NomObjVal = float(RRFile.read())

# Load the Optimization Control Information
PN, PC = np.load(DataDir + 'PControls.npy')

# Count the Active Parameters
Num_Prms = sum(1 for bl in PC if eval(bl))
print(Num_Prms)

PrmData = np.zeros([25000,Num_Prms])
ObjData = np.zeros(25000)

with open(DataDir + FileName) as DataFile:
    for i, line in enumerate(DataFile):
        if i > 0:
            temp = line.split()
            PrmData[i-1,:]  = temp[2:Num_Prms+2]
            ObjData[i-1] = temp[Num_Prms+2]

# index = np.where(ObjData == ObjData.min())
# PrmVal_best = np.squeeze(PrmData[index[0],:])

Indices = np.argsort(ObjData)

BetterThanNom = (ObjData < NomObjVal).astype(int).sum()

print(BetterThanNom ' samples were better than nominal run.')
if BetterThanNom > 10:
    tests = 10
else:
    tests = BetterThanNom

for tst in range(tests)
    np.save("BATS/PrmVals_BATS_51Prms_5Fld_T" + str(tst), np.squeeze(PrmData[Indices[tst]]))
