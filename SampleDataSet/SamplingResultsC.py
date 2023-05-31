import numpy as np

NumBTest = 20

DataDirB = '../SRuns/BATS-51P-NrmWrSTD-5Fld-PV4/'
DataDirH = '../SRuns/HOTS-51P-NrmWrSTD-5Fld-PV4/'
FileName = 'PEOutput.dat'

BRFile = open(DataDirB + 'RefRun/result.out')
HRFile = open(DataDirH + 'RefRun/result.out')
NomObjVal = float(BRFile.read()) + float(HRFile.read())

NumPrms = 51
NumEval = 25000

PrmData = np.zeros([NumEval,NumPrms])

ObjDataB = np.zeros(NumEval)
ObjDataH = np.zeros(NumEval)

with open(DataDirB + FileName) as DataFile:
    for i, line in enumerate(DataFile):
        if i > 0:
            temp = line.split()
            PrmData[i-1,:]  = temp[2:NumPrms+2]
            ObjDataB[i-1] = temp[NumPrms+2]

with open(DataDirH + FileName) as DataFile:
    for i, line in enumerate(DataFile):
        if i > 0:
            temp = line.split()
            ObjDataH[i-1] = temp[NumPrms+2]

ObjData = ObjDataB + ObjDataH

# index = np.where(ObjData == ObjData.min())
# PrmVal_best = np.squeeze(PrmData[index[0],:])

Indices = np.argsort(ObjData)

BetterThanNom = (ObjData < NomObjVal).astype(int).sum()

print(str(BetterThanNom) + ' samples were better than nominal run.')

for tst in range(NumBTest):
    # print(Indices[tst])
    # print(ObjData[Indices[tst]])
    # print(PrmData[Indices[tst]])
    np.save("Comb-51-PV4-TEST2/PrmVals_Set" + str(tst), np.squeeze(PrmData[Indices[tst]]))
