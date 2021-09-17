import numpy as np
import os

# Parameter Names
PN = []
# Parameter Controls
PC = []
# Parameter Nominal Values
NV = np.zeros(51)
# Parameter Lower Bound
LB = np.zeros(51)
# Parameter Upper Bound
UB = np.zeros(51)

with open('OptCase2.in') as readFile:
    for i, line in enumerate(readFile):
        if i >= 27 and i <= 77:
            Parameter_Entry = line.split()
            # print(line)
            # print(Parameter_Entry)

            # Assign Parameter Name
            PN.append(Parameter_Entry[1])
            # Assign Parameter Control
            PC.append(eval(Parameter_Entry[2]))
            # Assign Parameter Nominal Value
            NV[i-27] = Parameter_Entry[3]
            # Assign Parameter Lower Boundary
            LB[i-27] = Parameter_Entry[4]
            # Assign Parameter Upper Boundary
            UB[i-27] = Parameter_Entry[5]

# Calculate the Normalized Nominal Values
Norm_Val = (NV - LB) / (UB - LB)

# Optimization Run Directory
RunDir = 'PE-Runs/Opt-TEST'

# Make Run Directory
os.system("mkdir " + RunDir)

# Compile BFM17 + POM1D
os.system("cp -r Source/Source-BFMPOM " + RunDir + "/Config")

os.chdir(RunDir + "/Config")
os.system("./Config_BFMPOM.sh")
os.chdir("../../../")

os.system("cp -r Source-Run" + RunDir + "/Source")
os.system("cp Source/interface.py " + RunDir + "/Source")

os.system("cp " + RunDir + "/Config/bin/pom.exe " + RunDir + "/Source")

os.system("cp Source/dakota.in " + RunDir)

# Set Up DAKOTA input file
for ind, prm in enumerate(PN):
    #  Only needed for the random sampling implementation
    # os.system("sed -i '' '/ samples =/s/$/ " + str(Num_Samples) + "/' " + RunDir + "/dakota.in")
    # os.system("sed -i '' '/ seed =/s/$/ " + str(DAKOTA_Seed) + "/' " + RunDir + "/dakota.in")

    if PC[ind]:
        os.system("sed -i '' \"/ descriptors =/s/$/ \'" + prm + "\'/\" " + RunDir + "/dakota.in")
        os.system("sed -i '' '/ initial_state =/s/$/ " + f"{Norm_Val[ind]:g}" + "/' " + RunDir + "/dakota.in")
        os.system("sed -i '' '/ lower_bounds =/s/$/ 0.0/' " + RunDir + "/dakota.in")
        os.system("sed -i '' '/ upper_bounds =/s/$/ 1.0/' " + RunDir + "/dakota.in")

# Output Information for interface.py
np.save(RunDir + "/PControls",np.array([PN,PC]))
np.save(RunDir + "/PValues", np.array([NV,LB,UB]))

# Run Dakota
os.chdir(RunDir)
os.system("dakota -i dakota.in -o output.out -e error.err")













############################ REFERENCE #########################################
# # Run Directory
# RunDir = 'SA-Runs/Samples2'
#

#


#
# # Template Run Directory
# os.system("cp -r Source/Source-Run " + RunDir + "/Source")
# os.system("cp " + RunDir + "/Config/bin/pom.exe " + RunDir + "/Source")
#
# # Copy Input Data
# os.system("cp -r Source/Inputs " + RunDir)
# # Copy Input Data
# os.system("cp -r Source/ObsData " + RunDir)
#

# # Copy DAKOTA input file
# os.system("cp Source/interface.py " + RunDir + "/Source")
# os.system("cp Source/CalcObjective.py " + RunDir + "/Source")
#
