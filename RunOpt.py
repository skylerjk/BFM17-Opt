import numpy as np

PN = []
PC = []
NV = np.zeros(51)
LB = np.zeros(51)
UB = np.zeros(51)

with open('OptCase2.in') as readFile:
    for i, line in enumerate(readFile):
        if i >= 27 and i <= 77:
            Parameter_Entry = line.split()
            # print(line)
            # print(Parameter_Entry)

            # Parameter Names
            PN.append(Parameter_Entry[1])
            # Parameter Controls
            PC.append(eval(Parameter_Entry[2]))
            # Parameter Nominal Values
            NV[i-27] = Parameter_Entry[3]
            # Parameter Lower Boundary
            LB[i-27] = Parameter_Entry[4]
            # Parameter Upper Boundary
            UB[i-27] = Parameter_Entry[5]

# Output Information for interface.py
np.save("PControls",np.array([PN,PC]))
np.save("PValues", np.array([NV,LB,UB]))
