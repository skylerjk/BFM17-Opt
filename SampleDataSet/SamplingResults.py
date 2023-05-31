import numpy as np

# Number of Best cases to output
NumBTest = 20

DataDir = '../SRuns/HOTS-51P-NrmWrSTD-5Fld-PV4/'
FileName = 'PEOutput.dat'

RRFile = open(DataDir + 'RefRun/result.out')
NomObjVal = float(RRFile.read())

# Load the Optimization Control Information
PN, PC = np.load(DataDir + 'PControls.npy')

# Count the Active Parameters
Num_Prms = sum(1 for bl in PC if eval(bl))

NumEval = 25000
# NumEval = 2500
PrmData = np.zeros([NumEval,Num_Prms])
ObjData = np.zeros(NumEval)

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

print(str(BetterThanNom) + ' samples were better than nominal run.')

for tst in range(NumBTest):
    # print(Indices[tst])
    # print(ObjData[Indices[tst]])
    # print(PrmData[Indices[tst]])
    np.save("Comb-51-PV4-TEST/PrmVals_Set" + str(tst), np.squeeze(PrmData[Indices[tst]]))
