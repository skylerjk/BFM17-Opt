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

# Load the Optimization Control Information
PN, PC = np.load('PControls.npy')
# Load the Parameter Values
NV, LB, UB = np.load('PValues.npy')

# Count the Active Parameters
Num_Prms = sum(1 for bl in PC if eval(bl))

# Declare Array for Optimizal Parameter Values
Norm_Val_Opt = np.zeros(Num_Prms)

# Read Optimal Parameter Values from File
with open('PrmSet.txt.txt') as readFile:
    for i, line in enumerate(readFile):
        if (i > 4) and (i < 34):
            Norm_Val_Opt[i-5] = line

# Declar Array for Run Parameter Values
RV = np.copy(NV)


# Calculate Parameter value for input
cnt = 0
for prm in range(51):
    if eval(PC[prm]):
        RV[prm] = Norm_Val_Opt[cnt] * (UB[prm]-LB[prm]) + LB[prm]

        cnt += 1

# Generate optimal run directory (OptRun)
os.system("cp -r Source OptRun")
os.chdir("OptRun")

# Writing Parameter Values to Namelists
for i, prm in enumerate(PN):
    Nml_File = find_key(Namelist_Dictionary, prm)

    # Replace value of current parameter
    os.system("sed -i'' \"s/{" + prm + "}/" + str(RV[i]) +"/\" " + Nml_File)

# Run Reference Evaluation
os.system("./pom.exe")
