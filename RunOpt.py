# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Script : RunOpt_V3.py                                                        #
#                                                                              #
# Description :                                                                #
# This script produces
#                                                                              #
# Development History :                                                        #
# Skyler Kern - October 20, 2021                                               #
#                                                                              #
# Institution :                                                                #
# This was created in support of research done in the Turbulence and Energy    #
# Systems Laboratory (TESLa) from the Paul M. Rady Department of Mechanical    #
# Engineering at the University of Colorado Boulder.                           #
#                                                                              #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Preface : Load Modules
import numpy as np
import random
import os

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # CODE                                                                     # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
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

# Define Function : find_key
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Function returns the Key for a given value from the dictionary
def find_key(Dict,val):
    key_list = list(Dict.keys())

    for key in key_list:
      Search_List = Dict[key]
      if val in Search_List:
        return key
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Get User Defined Optimization Setup Selections from OptCase.in           # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Parameter Names
PN = []
# Parameter Controls
PC = []
# Parameter Nominal Values
NV = np.zeros(51)
# Parameter Perturbed Values
PV = np.zeros(51)
# Parameter Lower Bound
LB = np.zeros(51)
# Parameter Upper Bound
UB = np.zeros(51)

# Parameter Inupute Line Number
LnPI = 20
with open('OptCase.in') as readFile:
    for i, line in enumerate(readFile):
        if i == 7:
            # Set Optimization Run Directory in OptCase.in
            Option_Cntrl = line.split()
            RunDir = Option_Cntrl[2]

        if i == 9:
            Option_Cntrl = line.split()
            Exprmt = Option_Cntrl[2]

        if i == 11:
            # Control whether objective funct. is normalized in OptCase.in
            Option_Cntrl = line.split()
            Flag_Norm = eval(Option_Cntrl[2])

        if i == 12:
            # Control whether objective funct. is normalized in OptCase.in
            Option_Cntrl = line.split()
            NormVal = Option_Cntrl[2]

        if i == 14:
            Option_Cntrl = line.split()
            Flag_MS = eval(Option_Cntrl[2])

        if i >= LnPI:
            Parameter_Entry = line.split()
            # print(line)
            # print(Parameter_Entry)

            # Assign Parameter Name
            PN.append(Parameter_Entry[1])
            # Assign Parameter Control
            PC.append(eval(Parameter_Entry[2]))
            # Assign Parameter Nominal Value
            NV[i-LnPI] = Parameter_Entry[3]
            # Assign Parameter Lower Boundary
            LB[i-LnPI] = Parameter_Entry[4]
            # Assign Parameter Upper Boundary
            UB[i-LnPI] = Parameter_Entry[5]

Home = os.getcwd()

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Make Optimization Run Directory                                          # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Make Run Directory
os.system("mkdir " + RunDir)

# Keep copy of OptCase.in in run directory
os.system("cp OptCase.in " + RunDir)

# Copy source code to compile BFM17 + POM1D
os.system("cp -r Source/Source-BFMPOM " + RunDir + "/Config")

# Compile BFM17 + POM1D, generate executable
os.chdir(RunDir + "/Config")
os.system("./Config_BFMPOM.sh")
os.chdir(Home)

# Create template folder for Optimization
os.system("cp -r Source/Source-Run " + RunDir + "/Source")

# Put executable in template folder
os.system("cp " + RunDir + "/Config/bin/pom.exe " + RunDir + "/Source")

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Generate Optimization Case - Complete Run Directory                      # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# IF Running an observing system simulation experiment #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
MaxPert = 0.1
if Exprmt == 'osse':
# Calculate Perturbed parameter values
    for iprm, prm_val in enumerate(NV):
        if PC[iprm]:
            # Constant Perturbation from nominal values
            PV[iprm] = NV[iprm] + MaxPert * NV[iprm]

            # Random Perturbation within +/- of max percentage
            # PV[iprm] = NV[iprm] + round(random.uniform(-MaxPert,MaxPert),4) * NV[iprm]

            # Correct val if perturbation moved normalized value out of bounds
            if PV[iprm] > UB[iprm]:
                # PV[iprm] = NV[iprm] - 0.05 * NV[iprm]
                PV[iprm] = UB[iprm]
            elif PV[iprm] < LB[iprm]:
                # PV[iprm] = NV[iprm] + 0.1 * NV[iprm]
                PV[iprm] = LB[iprm]

        else:
            PV[iprm] = NV[iprm]

        # Calculate the normalized parameter values: Normalized to range 0 to 1
        PV_Norm = (PV - LB) / (UB - LB)

    # Number of Days to simulation in OSSE
    os.system("sed -i'' \"s/{SimDays}/30/\" " + RunDir + "/Source/params_POMBFM.nml")

    # Put input data from the BATS site into opt dir
    os.system("cp -r Source/inputs_bats " + RunDir )

    # Identify input files
    os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" " + RunDir + "/Source/BFM_General.nml")
    os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" " + RunDir + "/Source/pom_input.nml")

# IF Running an parameter estimation study with obs data #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
elif Exprmt == 'bats' or Exprmt == 'hots' or Exprmt == 'comb':
    # Calculate normalized nominal parameter values
    PV_Norm = (NV - LB) / (UB - LB)

    # Copies code for running model with optimized parameters
    os.system("cp Source/RunOptSol.py " + RunDir)

    # Number of Days to simulation
    os.system("sed -i'' \"s/{SimDays}/1080/\" " + RunDir + "/Source/params_POMBFM.nml")

    if Exprmt == 'bats' or Exprmt == 'comb':
        # Put input data from the BATS site into opt dir
        os.system("cp -r Source/inputs_bats " + RunDir )
        # Put observational data from the BATS site into opt dir
        os.system("cp -r Source/ObsBATS " + RunDir )

        # Insert input directory
        os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" " + RunDir + "/Source/BFM_General.nml")
        os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" " + RunDir + "/Source/pom_input.nml")

    if Exprmt == 'hots' or Exprmt == 'comb':
        # Put input data from the BATS site into opt dir
        os.system("cp -r Source/inputs_hots " + RunDir )
        # Put observational data from the HOTS site into opt dir
        os.system("cp -r Source/ObsHOTS " + RunDir )

        if Exprmt == 'hots':
            # Insert input directory
            os.system("sed -i'' \"s/{InDir}/..\/inputs_hots/\" " + RunDir + "/Source/BFM_General.nml")
            os.system("sed -i'' \"s/{InDir}/..\/inputs_hots/\" " + RunDir + "/Source/pom_input.nml")

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Experiment Independent Set-up                                            # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Set Up DAKOTA input file #
# =-=-=-=-=-=-=-=-=-=-=-=- #
os.system("cp Source/dakota.in " + RunDir + "/dakota.in")

# Interface inputs - case and normalization selection
os.system("sed -i'' 's/NORM_CONTROL/"+ str(Flag_Norm) + "/' " + RunDir + "/dakota.in")
os.system("sed -i'' 's/EXPRMT/"+ Exprmt + "/' " + RunDir + "/dakota.in")

# DAKOTA Controls for input file Multi-Start Method Block
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
if Flag_MS:
    # Create multi-start method block
    os.system("sed -i'' 's/BLCK_MltStrt/method/' " + RunDir + "/dakota.in")
    # Identify Optimization Method Block
    os.system("sed -i'' 's/MS_MP/method_pointer = '\\''QN'\\''/' " + RunDir + "/dakota.in")
    # Number of Random Starts
    os.system("sed -i'' 's/MS_NS/random_starts = 10/' " + RunDir + "/dakota.in")
    # Seed from Random Starts
    os.system("sed -i'' 's/MS_SD/seed = 2828/' " + RunDir + "/dakota.in")

    # Optimizer Method Block is given ID
    os.system("sed -i'' 's/DI_ID/id_method = '\\''QN'\\''/' " + RunDir + "/dakota.in")

else:
    # Do not need any of the multi-start method block
    os.system("sed -i'' '/BLCK_MltStrt/d' " + RunDir + "/dakota.in")
    os.system("sed -i'' '/multi_start/d' " + RunDir + "/dakota.in")
    os.system("sed -i'' '/MS_MP/d' " + RunDir + "/dakota.in")
    os.system("sed -i'' '/MS_NS/d' " + RunDir + "/dakota.in")
    os.system("sed -i'' '/MS_SD/d' " + RunDir + "/dakota.in")

    # Method Block ID is unnecessary
    os.system("sed -i'' '/DI_ID/d' " + RunDir + "/dakota.in")

# DAKOTA Controls for input file Optimizer Method Block
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
# Optimization Method : Opt++ Quasi-Newton Method
os.system("sed -i'' 's/DI_MTHD/optpp_q_newton/' " + RunDir + "/dakota.in")
# Convergence Criteria :
os.system("sed -i'' 's/DI_CT/convergence_tolerance = 1.e-4/' " + RunDir + "/dakota.in")
# Max Number of Iterations
os.system("sed -i'' 's/DI_MI/max_iterations = 50000/' " + RunDir + "/dakota.in")
# Max Number of Model Evaluations
os.system("sed -i'' 's/DI_FE/max_function_evaluations = 100000/' " + RunDir + "/dakota.in")
# Search Method
os.system("sed -i'' 's/DI_LS/search_method value_based_line_search/' " + RunDir + "/dakota.in")
# Merit Function : argaez_tapia, el_bakry, van_shanno
os.system("sed -i'' 's/DI_MF/merit_function argaez_tapia/' " + RunDir + "/dakota.in")
# Max Step Size
os.system("sed -i'' 's/DI_MxStp/max_step = 1000.0/' " + RunDir + "/dakota.in")
# Gradient Tolerance
os.system("sed -i'' 's/DI_GrdTol/gradient_tolerance = 1.e-4/' " + RunDir + "/dakota.in")

# DAKOTA Controls for input file Response Block
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
# Finite Differencing Routine Source
os.system("sed -i'' 's/DI_MthdSrc/method_source dakota/' " + RunDir + "/dakota.in")
# Gradient Approximation Approach
os.system("sed -i'' 's/DI_IT/interval_type forward/' " + RunDir + "/dakota.in")
# Finite Differencing Step Size
os.system("sed -i'' 's/DI_GrdStp/fd_gradient_step_size = 1.e-5/' " + RunDir + "/dakota.in")

# DAKOTA Controls for input file Variable Block
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
prm_cnt = 0
for ind, prm in enumerate(PN):
    if PC[ind]:
        os.system("sed -i'' \"/descriptors =/s/$/ \\'" + prm + "\\'/\" " + RunDir + "/dakota.in")
        os.system("sed -i'' '/initial_point =/s/$/ " + f"{PV_Norm[ind]:g}" + "/' " + RunDir + "/dakota.in")

        os.system("sed -i'' '/lower_bounds =/s/$/ 0.0/' " + RunDir + "/dakota.in")
        os.system("sed -i'' '/upper_bounds =/s/$/ 1.0/' " + RunDir + "/dakota.in")

        prm_cnt += 1

os.system("sed -i'' '/continuous_design =/s/$/ " + str(prm_cnt) + "/' " + RunDir + "/dakota.in")

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
# Done setting up dakota.in                                     #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

# Output Information for interface.py
np.save(RunDir + "/PControls",np.array([PN,PC]))
np.save(RunDir + "/PValues", np.array([NV,LB,UB]))

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Perform Reference Model Run
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Generate reference run directory (RefRun)
os.system("cp -r " + RunDir + "/Source " + RunDir + "/RefRun")

# Input nominal set of parameter values
os.chdir(RunDir + "/RefRun")
# Writing Parameter Values to Namelists
for i, prm in enumerate(PN):
    Nml_File = find_key(Namelist_Dictionary, prm)
    # Replace of current parameter in namelist with nominal value
    os.system("sed -i'' \"s/{" + prm + "}/" + str(NV[i]) +"/\" " + Nml_File)

# Run Reference Evaluation
os.system("./pom.exe")

if Exprmt == 'osse':
    # Move Reference Run to template directory
    os.system("cp bfm17_pom1d.nc ../Source/bfm17_pom1d-ref.nc ")

elif Exprmt == 'comb':
    # Move BATS model evaluation data to new file reference
    os.system("mv bfm17_pom1d.nc bfm17_pom1d_bats.nc")

    os.system("sed -i'' \"s/inputs_bats/inputs_hots/\" BFM_General.nml")
    os.system("sed -i'' \"s/inputs_bats/inputs_hots/\" pom_input.nml")

    os.system("./pom.exe")

    # Move HOTS model evaluation data to new file reference
    os.system("mv bfm17_pom1d.nc bfm17_pom1d_hots.nc")

if Flag_Norm:
    os.system("cp " + Home + "/Source/NrmFuncts/CalcNormVals_" + Exprmt + ".py CalcNormVals.py")

    # Calculate the values for normalizing objective function
    os.system("python3 CalcNormVals.py " + NormVal)
    # Move Reference Run to template directory
    os.system("cp NormVals.npy ../")

# Return to home directory
os.chdir(Home)

# Move interface to template directory
os.system("cp Source/interface.py " + RunDir + "/Source/interface.py")

# Copy objective function calculator to template directory
os.system("cp Source/ObjFncts/CalcObjective_" + Exprmt + ".py " + RunDir + "/Source/CalcObjective.py")

# End of Reference Run
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Run Dakota
os.chdir(RunDir)
os.system("dakota -i dakota.in -o output.out -e error.err")
