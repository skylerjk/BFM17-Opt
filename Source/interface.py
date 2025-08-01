import numpy as np
import os
import sys

# Namelist Dictionary defines which parameters are in a given namelist file
Namelist_Dictionary = {
  'BFM_General.nml' : ['p_PAR', 'p_eps0', 'p_epsR6', 'p_pe_R1c', 'p_pe_R1n', 'p_pe_R1p','SchmidtO2','d_wan'],
  'Pelagic_Ecology.nml' : ['p_sum', 'p_srs', 'p_sdmo', 'p_thdo', 'p_pu_ea', 'p_pu_ra', \
  'p_qun', 'p_lN4', 'p_qnlc', 'p_qncPPY', 'p_xqn', 'p_qup', 'p_qplc', 'p_qpcPPY', \
  'p_xqp', 'p_esNI', 'p_res', 'p_alpha_chl', 'p_qlcPPY', 'p_epsChla', 'z_srs', 'z_sum', \
  'z_sdo', 'z_sd', 'z_pu', 'z_pu_ea', 'z_chro', 'z_chuc', 'z_minfood', 'z_qpcMIZ', \
  'z_qncMIZ', 'z_paPPY'],
  'Pelagic_Environment.nml' : ['p_sN4N3', 'p_clO2o', 'p_sR6O3', 'p_sR6N1', 'p_sR6N4', \
  'p_sR1O3', 'p_sR1N1', 'p_sR1N4', 'p_rR6m'],
  'params_POMBFM.nml' : ['NRT_o2o', 'NRT_n1p', 'NRT_n3n', 'NRT_n4n','A1','B1','A2','B2','C1','E1','E2']
}

# Function to return Key for parameter Dictionary
def find_key(Dict,val):
    key_list = list(Dict.keys())

    for key in key_list:
      Search_List = Dict[key]
      if val in Search_List:
        return key

# Optimizing Weddy Coefficients
OptWEd = eval(sys.argv[1])
# Normalization On - True/False
NormOn = eval(sys.argv[2])
# Experiment being run 
Exprmt = sys.argv[3]


# Load the Optimization Control Information
PN, PC = np.load('../PControls.npy')
# Load the Parameter Values
NV, LB, UB = np.load('../PValues.npy')
# Number of Parameters Possible
NumPrms = len(PN)
OptPrms = sum(1 for bl in PC if eval(bl))
# Array for norm parameter vals
Norm_PVal = np.zeros(OptPrms)

if OptWEd:
    # Load Coefficient Values
    CNV, CLB, CUB = np.load('../CValues.npy')
    Seconds_in_Day = 60.*60.*24.

    # Load General Circulation Data
    File_Loc_WGen =  "../inputs_" + Exprmt + "/bfm17_pom/mon_vprof_wgen.da"
    Handle_File_WGen = open(File_Loc_WGen,'rb')
    data = np.fromfile(Handle_File_WGen, dtype=np.float64)
    # WGen is in units of m/s
    WGen = np.reshape(data,(13,151))

    # Number of Coefficients
    NumCoef = 24
    # Array for norm coefficient vals
    Norm_CVal = np.zeros(NumCoef)

# Run Parameter Values
RV = np.copy(NV)

with open('params.in') as readFile:
    for i, line in enumerate(readFile):
        if i == 0:
            Parameter_Entry = line.split()
            OptVar = int(Parameter_Entry[3])

            Parameter_Names = []
            Norm_Val = np.zeros(OptVar)
        if 1 <= i < 1+OptPrms :
            Parameter_Entry = line.split()
            # Parameter Value - Normalized
            Norm_PVal[i-1] = Parameter_Entry[3]
        
        if OptWEd:
            if 1+OptPrms <= i < 1+OptPrms+NumCoef:
                Parameter_Entry = line.split()
                # Coefficient Value - Normalized
                Norm_CVal[i-(1+OptPrms)] = Parameter_Entry[3]



# Calculate Parameter value for input
cnt = 0
for prm in range(NumPrms):
    if eval(PC[prm]):
        RV[prm] = Norm_PVal[cnt] * (UB[prm]-LB[prm]) + LB[prm]

        cnt += 1

# Writing Parameter Values to Namelists
for i, prm in enumerate(PN):
    Nml_File = find_key(Namelist_Dictionary, prm)

    # Replace value of current parameter
    os.system("sed -i'' \"s/{" + prm + "}/" + str(RV[i]) +"/\" " + Nml_File)

if OptWEd:
    CV1 = np.zeros(12)
    CV2 = np.zeros(12)
    # Calculate Coefficient Values
    for ico in range(12):
        CV1[ico] = Norm_CVal[ico] * (CUB[ico] - CLB[ico]) + CLB[ico]
        CV2[ico] = Norm_CVal[ico+12] * (CUB[ico+12] - CLB[ico+12]) + CLB[ico+12]

    WEd1 = np.zeros([13,151])
    WEd2 = np.zeros([13,151])
    for mon in range(13):
        if mon == 0:
            # WEddy is output in m/d
            WEd1[0,:] = CV1[11]*WGen[0,:]*Seconds_in_Day
            WEd2[0,:] = CV2[11]*WGen[0,:]*Seconds_in_Day
        elif mon > 0: 
            # WEddy is output in m/d
            WEd1[mon,:] = CV1[mon-1]*WGen[mon,:]*Seconds_in_Day
            WEd2[mon,:] = CV2[mon-1]*WGen[mon,:]*Seconds_in_Day

    # 
    File_Loc_WEd1 = 'vprof_weddy1.da'
    Handle_File_WEd1 = open(File_Loc_WEd1,'wb')
    WEd1.tofile(Handle_File_WEd1)

    # 
    File_Loc_WEd2 = 'vprof_weddy2.da'
    Handle_File_WEd2 = open(File_Loc_WEd2,'wb')
    WEd2.tofile(Handle_File_WEd2)


# Run POM
os.system("./pom.exe")

if Exprmt == 'comb':
    # Move BATS model evaluation data to new file reference
    os.system("mv bfm17_pom1d.nc bfm17_pom1d_bats.nc")

    os.system("sed -i'' \"s/inputs_bats/inputs_hots/\" BFM_General.nml")
    os.system("sed -i'' \"s/inputs_bats/inputs_hots/\" pom_input.nml")

    os.system("./pom.exe")

    # Move HOTS model evaluation data to new file reference
    os.system("mv bfm17_pom1d.nc bfm17_pom1d_hots.nc")

# Calculate Objective function
os.system("python3 CalcObjective.py " + str(NormOn))
