import numpy as np

DataDir = '../SmpRun/BATS-NrmWrSTD-5Fld-All3-Baseline/'
# DataDir = '../TSE/TSE-Smp-NrmWrSTD-5Fld-BGC3-Baseline/'
FileName = 'PEOutput.dat'

OptWEd = True
# OptWEd = False

RRFile = open(DataDir + 'RefRun/result.out')
NomObjVal = float(RRFile.read())

# Load the Optimization Control Information
PN, PC = np.load(DataDir + 'PControls.npy')

# Count the Active Parameters
NumPrms = sum(1 for bl in PC if eval(bl))
if OptWEd:
    NumPrms = NumPrms + 24

# NumEval = 10000
NumEval = 20000
PrmData = np.zeros([NumEval,NumPrms])
ObjData = np.zeros(NumEval)

with open(DataDir + FileName) as DataFile:
    for i, line in enumerate(DataFile):
        if i > 0:
            temp = line.split()
            PrmData[i-1,:]  = temp[2:NumPrms+2]
            ObjData[i-1] = temp[NumPrms+2]

# index = np.where(ObjData == ObjData.min())
# PrmVal_best = np.squeeze(PrmData[index[0],:])

Indices = np.argsort(ObjData)

BetterThanNom = (ObjData < NomObjVal).astype(int).sum()

print(str(BetterThanNom) + ' samples were better than nominal run.')
print('Objective function for Baseline Case is: ' + str(NomObjVal))
print('20 Best Cases')
for i in range(20):
    print(ObjData[Indices[i]])
    np.save("BATS-All3/PrmVals_Set" + str(i), np.squeeze(PrmData[Indices[i]]))
