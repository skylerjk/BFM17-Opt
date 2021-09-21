import numpy as np

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

# Run Parameter Values
RV = np.copy(NV)

Norm_Val = np.array([0.5,0.6,0.4,0.3,0.2])

with open('params.in') as readFile:
    for i, line in enumerate(readFile):
        if i == 0:
            Parameter_Entry = line.split()
            Num_Prms = int(Parameter_Entry[3])

            Parameter_Names = []
            Norm_Val = np.zeros(Num_Prms)
        if (i >= 1) and (i < 1+Num_Prms) :
            Parameter_Entry = line.split()
            # Parameter Value - Normalized
            Prm_Vals_Norm[i-1] = Parameter_Entry[3]

cnt = 0
for prm in range(51):
    if eval(PC[prm]):
        RV[prm] = Norm_Val[cnt] * (UB[prm]-LB[prm]) + LB[prm]
        cnt += 1

# Writing Parameter Values to Namelists
for i, prm in enumerate(PN):
    Nml_File = find_key(Namelist_Dictionary, prm)

    # Replace value of current parameter
    os.system("sed -i '' \"s/{" + prm + "}/" + str(RV[i]) +"/\" " + Nml_File)

# Run POM
os.system("./pom.exe")

# Calculate Objective function
exec(open("CalcObjective.py").read())
