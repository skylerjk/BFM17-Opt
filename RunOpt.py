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
import sys

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # CODE                                                                     # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
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

# Entry 1: Procedure - smp/opt
# Entry 2: Exprement - tseb, bats, hots, comb
# Entry 3: Normalize RMSD - True/False
# Entry 4: Normalization - rSTD/RMSD/othr
# Entry 5: Sample Values - True/False (False runs with nominal values)
# Entry 6: Run Directory
# Entry 7: Sampled Values File

Proc = sys.argv[1]
Exprmt = sys.argv[2]
NormON = eval(sys.argv[3])
NormVal = sys.argv[4]
SmplON = eval(sys.argv[5])
HomDir = sys.argv[6]
SmpLoc = sys.argv[7]

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Get User Defined Optimization Setup Selections from OptCase.in           # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

NumPrms = 60
# Parameter Names
PN = []
# Parameter Controls
PC = []
# Parameter Nominal Values
NV = np.zeros(NumPrms)
# Parameter Perturbed Values
PV = np.zeros(NumPrms)
# Parameter Lower Bound
LB = np.zeros(NumPrms)
# Parameter Upper Bound
UB = np.zeros(NumPrms)

MltStrON = False

# Parameter Inupute Line Number
LnPI = 4
with open('Parameters.in') as readFile:
    for i, line in enumerate(readFile):
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

            if Exprmt == 'tseb':
                # Assign Parameter Lower Boundary
                # LB[i-LnPI] = NV[i-LnPI] - 0.25 * NV[i-LnPI]
                LB[i-LnPI] = Parameter_Entry[4]
                # Assign Parameter Upper Boundary
                # UB[i-LnPI] = NV[i-LnPI] + 0.25 * NV[i-LnPI]
                UB[i-LnPI] = Parameter_Entry[5]
            else:
                # Assign Parameter Lower Boundary
                LB[i-LnPI] = Parameter_Entry[4]
                # Assign Parameter Upper Boundary
                UB[i-LnPI] = Parameter_Entry[5]

RunDir = os.getcwd() 

# print(Proc)
# print(Exprmt)
# print(NormON)
# print(NormVal)
# print(SmplON)
# print(HomDir)
# print(SmpLoc)
# print(PN)

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Make Optimization Run Directory                                          # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# # Copy source code to compile BFM17 + POM1D
# os.system("cp -r " + HomDir + "/Source/Source-BFMPOM Config")

# Compile BFM17 + POM1D, generate executable
os.chdir("Config")
os.system("./Config_BFMPOM.sh")
os.chdir("..")

# # Create template folder for Optimization
# os.system("cp -r " + HomDir + "/Source/Source-Run")

# Put executable in template folder
os.system("cp Config/bin/pom.exe Source")

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Generate Optimization Case - Complete Run Directory                      # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# IF Running an observing system simulation experiment #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
MaxPert = 0.1
if Exprmt == 'tseb':
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

    # Number of Days to simulation in Twin Simulations
    # os.system("sed -i'' \"s/{SimDays}/30/\" Source/params_POMBFM.nml")
    os.system("sed -i'' \"s/{SimDays}/1080/\" Source/params_POMBFM.nml")

    # Put input data from the BATS site into opt dir
    os.system("cp -r " + HomDir + "/Source/inputs_bats .")

    # Identify input files
    os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" Source/BFM_General.nml")
    os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" Source/pom_input.nml")

# IF Running an parameter estimation study with obs data #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
elif Exprmt == 'bats' or Exprmt == 'hots' or Exprmt == 'comb':
    # Calculate normalized nominal parameter values
    PV_Norm = (NV - LB) / (UB - LB)

    if SmplON:
        TV_Norm = np.load(SmpLoc)

        iprm_sv = 0
        for iprm, prm_val in enumerate(NV):
            if PC[iprm]:
                PV_Norm[iprm] = TV_Norm[iprm_sv]
                iprm_sv += 1

        # Test Values - If wanting ref run to use smpl vals
        # TV = PV_Norm * (UB - LB) + LB

    # # Copies code for running model with optimized parameters
    # os.system("cp " + HomDir + "/Source/RunSol.py .")

    # Number of Days to simulation
    os.system("sed -i'' \"s/{SimDays}/1080/\" Source/params_POMBFM.nml")

    if Exprmt == 'bats' or Exprmt == 'comb':
        # Put input data from the BATS site into opt dir
        os.system("cp -r " + HomDir + "/Source/inputs_bats .")
        # Put observational data from the BATS site into opt dir
        os.system("cp -r " + HomDir + "/Source/ObsBATS .")

        # Insert input directory
        os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" Source/BFM_General.nml")
        os.system("sed -i'' \"s/{InDir}/..\/inputs_bats/\" Source/pom_input.nml")

    if Exprmt == 'hots' or Exprmt == 'comb':
        # Put input data from the BATS site into opt dir
        os.system("cp -r " + HomDir + "/Source/inputs_hots .")
        # Put observational data from the HOTS site into opt dir
        os.system("cp -r " + HomDir + "/Source/ObsHOTS .")

        if Exprmt == 'hots':
            # Insert input directory
            os.system("sed -i'' \"s/{InDir}/..\/inputs_hots/\" Source/BFM_General.nml")
            os.system("sed -i'' \"s/{InDir}/..\/inputs_hots/\" Source/pom_input.nml")

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Experiment Independent Set-up                                            # #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Set Up DAKOTA input file #
# =-=-=-=-=-=-=-=-=-=-=-=- #
# os.system("cp " + HomDir + "/Source/dakota.in dakota.in")

# Interface inputs - case and normalization selection
os.system("sed -i'' 's/NORM_CONTROL/"+ str(NormON) + "/' dakota.in")
os.system("sed -i'' 's/EXPRMT/"+ Exprmt + "/' dakota.in")

if Proc == 'smp':
    # Do not need any of the multi-start method block
    os.system("sed -i'' '/BLCK_MltStrt/d' dakota.in")
    os.system("sed -i'' '/multi_start/d' dakota.in")
    os.system("sed -i'' '/MS_MP/d' dakota.in")
    os.system("sed -i'' '/MS_NS/d' dakota.in")
    os.system("sed -i'' '/MS_SD/d' dakota.in")
    # Method Block ID is unnecessary
    os.system("sed -i'' '/DI_ID/d' dakota.in")

    os.system("sed -i'' 's/DI_MTHD/sampling/' dakota.in")
    os.system("sed -i'' 's/DI_CT/sample_type lhs/' dakota.in")
    # os.system("sed -i'' 's/DI_FE/samples = 2500/' dakota.in")
    os.system("sed -i'' 's/DI_FE/samples = 25000/' dakota.in")
    os.system("sed -i'' 's/DI_LS/seed = 26862/' dakota.in")

    os.system("sed -i'' '/DI_MI/d' dakota.in")
    os.system("sed -i'' '/DI_MF/d' dakota.in")
    os.system("sed -i'' '/DI_MxStp/d' dakota.in")
    os.system("sed -i'' '/DI_GrdTol/d' dakota.in")

    os.system("sed -i'' 's/numerical_gradients/no_gradients/' dakota.in")
    os.system("sed -i'' '/DI_MthdSrc/d' dakota.in")
    os.system("sed -i'' '/DI_IT/d' dakota.in")
    os.system("sed -i'' '/DI_GrdStp/d' dakota.in")

    os.system("sed -i'' 's/continuous_design =/uniform_uncertain =/' dakota.in")
    os.system("sed -i'' 's/objective_functions = 1/response_functions = 1/' dakota.in")

elif Proc == 'opt':
    # DAKOTA Controls for input file Multi-Start Method Block
    # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

    if MltStrON:
        # Create multi-start method block
        os.system("sed -i'' 's/BLCK_MltStrt/method/' dakota.in")
        # Identify Optimization Method Block
        os.system("sed -i'' 's/MS_MP/method_pointer = '\\''QN'\\''/' dakota.in")
        # Number of Random Starts
        os.system("sed -i'' 's/MS_NS/random_starts = 10/' dakota.in")
        # Seed from Random Starts
        os.system("sed -i'' 's/MS_SD/seed = 2828/' dakota.in")

        # Optimizer Method Block is given ID
        os.system("sed -i'' 's/DI_ID/id_method = '\\''QN'\\''/' dakota.in")

    else:
        # Do not need any of the multi-start method block
        os.system("sed -i'' '/BLCK_MltStrt/d' dakota.in")
        os.system("sed -i'' '/multi_start/d' dakota.in")
        os.system("sed -i'' '/MS_MP/d' dakota.in")
        os.system("sed -i'' '/MS_NS/d' dakota.in")
        os.system("sed -i'' '/MS_SD/d' dakota.in")

        # Method Block ID is unnecessary
        os.system("sed -i'' '/DI_ID/d' dakota.in")

    # DAKOTA Controls for input file Optimizer Method Block
    # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
    # Optimization Method : Opt++ Quasi-Newton Method
    os.system("sed -i'' 's/DI_MTHD/optpp_q_newton/' dakota.in")
    # Convergence Criteria :
    os.system("sed -i'' 's/DI_CT/convergence_tolerance = 1.e-4/' dakota.in")
    # Max Number of Iterations
    os.system("sed -i'' 's/DI_MI/max_iterations = 50000/' dakota.in")
    # Max Number of Model Evaluations
    os.system("sed -i'' 's/DI_FE/max_function_evaluations = 100000/' dakota.in")
    # Search Method
    os.system("sed -i'' 's/DI_LS/search_method value_based_line_search/' dakota.in")
    # Merit Function : argaez_tapia, el_bakry, van_shanno
    os.system("sed -i'' 's/DI_MF/merit_function argaez_tapia/' dakota.in")
    # Max Step Size
    os.system("sed -i'' 's/DI_MxStp/max_step = 1000.0/' dakota.in")
    # Gradient Tolerance
    os.system("sed -i'' 's/DI_GrdTol/gradient_tolerance = 1.e-4/' dakota.in")

    # DAKOTA Controls for input file Response Block
    # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
    # Finite Differencing Routine Source
    os.system("sed -i'' 's/DI_MthdSrc/method_source dakota/' dakota.in")
    # Gradient Approximation Approach
    os.system("sed -i'' 's/DI_IT/interval_type forward/' dakota.in")
    # Finite Differencing Step Size
    os.system("sed -i'' 's/DI_GrdStp/fd_gradient_step_size = 1.e-5/' dakota.in")

# DAKOTA Controls for input file Variable Block
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
prm_cnt = 0
for ind, prm in enumerate(PN):
    if PC[ind]:
        os.system("sed -i'' \"/descriptors =/s/$/ \\'" + prm + "\\'/\" dakota.in")

        if Proc == 'opt':
            os.system("sed -i'' '/initial_point =/s/$/ " + f"{PV_Norm[ind]:g}" + "/' dakota.in")

        os.system("sed -i'' '/lower_bounds =/s/$/ 0.0/' dakota.in")
        os.system("sed -i'' '/upper_bounds =/s/$/ 1.0/' dakota.in")

        prm_cnt += 1

if Proc == 'smp':
    os.system("sed -i'' '/uniform_uncertain =/s/$/ " + str(prm_cnt) + "/' dakota.in")
    os.system("sed -i'' '/initial_point =/d' " + RunDir + "/dakota.in")

elif Proc == 'opt':
    os.system("sed -i'' '/continuous_design =/s/$/ " + str(prm_cnt) + "/' dakota.in")


# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
# Done setting up dakota.in                                     #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

# Output Information for interface.py
np.save("PControls",np.array([PN,PC]))
np.save("PValues", np.array([NV,LB,UB]))

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Produce Synthetic Observational data for TSE
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
if Exprmt == 'tseb':
    os.system("cp -r Source SynRef")
    os.chdir("SynRef")

    # Writing Parameter Values to Namelists
    for i, prm in enumerate(PN):
        Nml_File = find_key(Namelist_Dictionary, prm)
        # Replace of current parameter in namelist with nominal value
        os.system("sed -i'' \"s/{" + prm + "}/" + str(NV[i]) +"/\" " + Nml_File)

    # Run Reference Evaluation
    os.system("./pom.exe")

    # Move Synthetic Reference Data to template directory
    os.system("cp bfm17_pom1d.nc ../Source/bfm17_pom1d-ref.nc ")

    # Return to run directory
    os.chdir("..")

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Perform Reference Model Run
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Generate reference run directory (RefRun)
os.system("cp -r Source RefRun")

# Input nominal set of parameter values
os.chdir("RefRun")
# Writing Parameter Values to Namelists
for i, prm in enumerate(PN):
    Nml_File = find_key(Namelist_Dictionary, prm)
    # Replace of current parameter in namelist with nominal value
    if Exprmt == 'tseb':
        os.system("sed -i'' \"s/{" + prm + "}/" + str(PV[i]) +"/\" " + Nml_File)
    else:
        os.system("sed -i'' \"s/{" + prm + "}/" + str(NV[i]) +"/\" " + Nml_File)

# Run Reference Evaluation
os.system("./pom.exe")

if Exprmt == 'comb':
    # Move BATS model evaluation data to new file reference
    os.system("mv bfm17_pom1d.nc bfm17_pom1d_bats.nc")

    os.system("sed -i'' \"s/inputs_bats/inputs_hots/\" BFM_General.nml")
    os.system("sed -i'' \"s/inputs_bats/inputs_hots/\" pom_input.nml")

    os.system("./pom.exe")

    # Move HOTS model evaluation data to new file reference
    os.system("mv bfm17_pom1d.nc bfm17_pom1d_hots.nc")

# Return to run directory
os.chdir("..")

if NormON:
    if NormVal == 'RMSD' or NormVal == 'rSTD':
        # Calculate the values for normalizing objective function
        os.system("python3 CalcNormVals.py " + NormVal)
        # # Move Reference Run to template directory
        # os.system("cp NormVals.npy ../")

# Run Dakota
os.system("dakota -i dakota.in -o output.out -e error.err")
