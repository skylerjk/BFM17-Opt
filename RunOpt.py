import numpy as np
import os

# Namelist Dictionary defines which parameters are in a given namelist file
Namelist_Dictionary = {
  'BFM_General.nml' : ['p_PAR', 'p_eps0', 'p_epsR6', 'p_pe_R1c', 'p_pe_R1n', 'p_pe_R1p'],
  'Pelagic_Ecology.nml' : ['p_sum', 'p_srs', 'p_sdmo', 'p_thdo', 'p_pu_ea', 'p_pu_ra', \
  'p_qun', 'p_lN4', 'p_qnlc', 'p_qncPPY', 'p_xqn', 'p_qup', 'p_qplc', 'p_qpcPPY', \
  'p_xqp', 'p_esNI', 'p_res', 'p_alpha_chl', 'p_qlcPPY', 'p_epsChla', 'z_srs', 'z_sum', \
  'z_sdo', 'z_sd', 'z_pu', 'z_pu_ea', 'z_chro', 'z_chuc', 'z_minfood', 'z_qpcMIZ', \
  'z_qncMIZ', 'z_paPPY'],
  'Pelagic_Environment.nml' : ['p_sN4N3', 'p_clO2o', 'p_sR6O3', 'p_sR6N1', 'p_sR6N4', \
  'p_sR1O3', 'p_sR1N1', 'p_sR1N4', 'p_rR6m'],
  'params_POMBFM.nml' : ['NRT_o2o', 'NRT_n1p', 'NRT_n3n', 'NRT_n4n']
}

# Function to return Key for parameter Dictionary
def find_key(Dict,val):
    key_list = list(Dict.keys())

    for key in key_list:
      Search_List = Dict[key]
      if val in Search_List:
        return key

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
        if i >= 4:
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

os.system("cp -r Source/Source-Run " + RunDir + "/Source")

os.system("cp " + RunDir + "/Config/bin/pom.exe " + RunDir + "/Source")

# Copy Input Data
os.system("cp -r Source/Source-BFMPOM/Inputs " + RunDir)


# Perform Reference Run
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
os.system("cp -r " + RunDir + "/Source " + RunDir + "/RefRun")
os.chdir(RunDir + "/RefRun")
# Writing Parameter Values to Namelists
for i, prm in enumerate(PN):
    Nml_File = find_key(Namelist_Dictionary, prm)

    # Replace value of current parameter
    os.system("sed -i '' \"s/{" + prm + "}/" + str(NV[i]) +"/\" " + Nml_File)
# Run Reference Evaluation
os.system("./pom.exe")
os.chdir("../../../")

# Complete Case Set-Up
# Move Reference Run to template directory
os.system("cp " + RunDir + "/RefRun/bfm17_pom1d.nc " + RunDir + "/Source/bfm17_pom1d-ref.nc ")
# Move interface to template directory
os.system("cp Source/interface.py " + RunDir + "/Source")
# Move objective function calculator to template directory
os.system("cp Source/CalcObjective.py " + RunDir + "/Source")
# Move DAKOTA input file to Run directory
os.system("cp Source/dakota.in " + RunDir)

prm_cnt = 0
# Set Up DAKOTA input file
for ind, prm in enumerate(PN):
    #  DAKOTA Controls setting up Optimization Method
    os.system("sed -i '' 's/ DI_MTHD/conmin_frcg/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_CT/convergence_tolerance = 1e-6/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_MI/max_iterations = 1000/' " + RunDir + "/dakota.in")

    if PC[ind]:
        InVal = Norm_Val[ind] + 0.1
        if InVal > 1.0:
            InVal = InVal - 1.0
        elif InVal < 0.0:
            InVal = InVal + 1.0

        os.system("sed -i '' \"/descriptors =/s/$/ \\'" + prm + "\\'/\" " + RunDir + "/dakota.in")
        os.system("sed -i '' '/initial_point =/s/$/ " + f"{Norm_Val[ind]:g}" + "/' " + RunDir + "/dakota.in")
        os.system("sed -i '' '/lower_bounds =/s/$/ 0.0/' " + RunDir + "/dakota.in")
        os.system("sed -i '' '/upper_bounds =/s/$/ 1.0/' " + RunDir + "/dakota.in")

        prm_cnt +=1

os.system("sed -i '' '/continuous_design =/s/$/ " + str(prm_cnt) + "/' " + RunDir + "/dakota.in")

# Output Information for interface.py
np.save(RunDir + "/PControls",np.array([PN,PC]))
np.save(RunDir + "/PValues", np.array([NV,LB,UB]))

# Run Dakota
os.chdir(RunDir)
os.system("dakota -i dakota.in -o output.out -e error.err")
