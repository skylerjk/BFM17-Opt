import numpy as np

PN, PC = np.load('PControls.npy')
NV, LB, UB = np.load('PValues.npy')

# Run Parameter Values
RV = NV

Norm_Val = np.array([0.5,0.6,0.4,0.3,0.2])

print(RV)

cnt = 0
for prm in range(51):
    if eval(PC[prm]):
        RV[prm] = Norm_Val[cnt] * UB[prm]-LB[prm] + LB[prm]
        cnt += 1

print(RV)
