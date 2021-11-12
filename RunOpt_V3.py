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
import os
# Code :
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

with open('OptCase.in') as readFile:
    for i, line in enumerate(readFile):
        if i == 7:
            # Set Optimization Run Directory in OptCase.in
            Option_Cntrl = line.split()
            RunDir = Option_Cntrl[2]

        if i == 9:
            # Control whether objective funct. is normalized in OptCase.in
            Option_Cntrl = line.split()
            OptMthd = Option_Cntrl[2]

        if i == 11:
            # Control whether objective funct. is normalized in OptCase.in
            Option_Cntrl = line.split()
            Flag_Norm = eval(Option_Cntrl[2])

        if i >= 17:
            Parameter_Entry = line.split()
            # print(line)
            # print(Parameter_Entry)

            # Assign Parameter Name
            PN.append(Parameter_Entry[1])
            # Assign Parameter Control
            PC.append(eval(Parameter_Entry[2]))
            # Assign Parameter Nominal Value
            NV[i-17] = Parameter_Entry[3]
            # Assign Parameter Lower Boundary
            LB[i-17] = Parameter_Entry[4]
            # Assign Parameter Upper Boundary
            UB[i-17] = Parameter_Entry[5]

Home = os.getcwd()

# Generate perturbed set of normalized values
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
for iprm, prm_val in enumerate(NV):
    if PC[iprm]:
        PV[iprm] = NV[iprm] + 0.1 * NV[iprm]

        # Correct val if perturbation moved normalized value out of 0 to 1 range
        if PV[iprm] > UB[iprm]:
            # PV[iprm] = NV[iprm] - 0.05 * NV[iprm]
            PV[iprm] = UB[iprm]
        elif PV[iprm] < LB[iprm]:
            # PV[iprm] = NV[iprm] + 0.1 * NV[iprm]
            PV[iprm] = LB[iprm]

    else:
        PV[iprm] = NV[iprm]

# Calculate the Normalized Nominal Values
# NV_Norm = (NV - LB) / (UB - LB)

PrmNrm_Mthd = 1
if PrmNrm_Mthd == 1:
    # Normalization method - range 0 to 1
    PV_Norm = (PV - LB) / (UB - LB)

elif PrmNrm_Mthd == 2:
    # Normalization method - normalize by nominal value
    PV_Norm = PV / NV

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

# Copy input data
os.system("cp -r Source/Source-BFMPOM/Inputs " + RunDir)

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Perform Reference Model Run
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Generate reference run directory (RefRun)
os.system("cp -r " + RunDir + "/Source " + RunDir + "/RefRun")
# Copy script for Calculating normalization values
os.system("cp Source/CalcNormVals.py " + RunDir + "/RefRun")

# Input nominal set of parameter values
os.chdir(RunDir + "/RefRun")
# Writing Parameter Values to Namelists
for i, prm in enumerate(PN):
    Nml_File = find_key(Namelist_Dictionary, prm)
    # Replace of current parameter in namelist with nominal value
    os.system("sed -i '' \"s/{" + prm + "}/" + str(NV[i]) +"/\" " + Nml_File)

# Run Reference Evaluation
os.system("./pom.exe")

# Move Reference Run to template directory
os.system("cp bfm17_pom1d.nc ../Source/bfm17_pom1d-ref.nc ")

if Flag_Norm:
    # Calculate the values for normalizing objective function
    os.system("python3 CalcNormVals.py")
    # Move Reference Run to template directory
    os.system("cp NormVals.npy ../Source")

# Return to home directory
os.chdir(Home)

# End of Reference Run
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Move objective function calculator to template directory
os.system("cp Source/CalcObjective_V2.py " + RunDir + "/Source/CalcObjective.py")

# Complete Case Set-Up

# Move interface to template directory
os.system("cp Source/interface_V2.py " + RunDir + "/Source/interface.py")

# Move DAKOTA input file to Run directory
os.system("cp Source/dakota_V2.in " + RunDir + "/dakota.in")
os.system("sed -i '' 's/NORM_CONTROL/"+ str(Flag_Norm) + "/' " + RunDir + "/dakota.in")


# Set Up DAKOTA input file
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
if OptMthd == 'conmin':
    # DAKOTA Controls for input file Method Block
    os.system("sed -i '' 's/ DI_MTHD/conmin_frcg/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_CT/convergence_tolerance = 1e-10/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_MI/max_iterations = 50000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_FE/max_function_evaluations = 100000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_SD/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_ID/d' " + RunDir + "/dakota.in")

    os.system("sed -i '' 's/DI_MS/method_source dakota/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_IT/interval_type forward/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_GS/fd_gradient_step_size = 0.00001/' " + RunDir + "/dakota.in")


elif OptMthd == 'cobyla':
    # DAKOTA Controls for input file Method Block
    os.system("sed -i '' 's/ DI_MTHD/coliny_cobyla/' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_CT/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_MI/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_FE/max_function_evaluations = 100000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_ID/initial_delta = 0.15/' " + RunDir + "/dakota.in")
    # os.system("sed -i '' '/DI_ID/d' " + RunDir + "/dakota.in")

    os.system("sed -i '' 's/DI_SD/seed = 101/' " + RunDir + "/dakota.in")
    # Turn off gradient calculation for COBYLA
    os.system("sed -i '' 's/numerical_gradients/no_gradients/' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_MS/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_IT/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_GS/d' " + RunDir + "/dakota.in")

elif OptMthd == 'optpp-cg':
    # DAKOTA Controls for input file Method Block
    os.system("sed -i '' 's/ DI_MTHD/optpp_cg/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_CT/convergence_tolerance = 1e-10/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_MI/max_iterations = 50000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_FE/max_function_evaluations = 100000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_SD/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_ID/d' " + RunDir + "/dakota.in")

    os.system("sed -i '' 's/DI_MS/method_source dakota/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_IT/interval_type forward/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_GS/fd_gradient_step_size = 0.00001/' " + RunDir + "/dakota.in")

    os.system("sed -i '' '/lower_bounds =/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/upper_bounds =/d' " + RunDir + "/dakota.in")

elif OptMthd == 'optpp-n':
    # DAKOTA Controls for input file Method Block
    os.system("sed -i '' 's/ DI_MTHD/optpp_newton/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_CT/convergence_tolerance = 1e-6/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_MI/max_iterations = 50000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_FE/max_function_evaluations = 100000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_SD/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_ID/d' " + RunDir + "/dakota.in")
    # DAKOTA Controls for input file Response Block
    os.system("sed -i '' 's/no_hessian/numerical_hessian/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_MS/method_source dakota/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_IT/interval_type forward/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_GS/fd_gradient_step_size = 0.001/' " + RunDir + "/dakota.in")

elif OptMthd == 'optpp-qn':
    # DAKOTA Controls for input file Method Block
    os.system("sed -i '' 's/ DI_MTHD/optpp_q_newton/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_CT/convergence_tolerance = 1e-6/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_MI/max_iterations = 50000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_FE/max_function_evaluations = 100000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_SD/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_ID/d' " + RunDir + "/dakota.in")
    # DAKOTA Controls for input file Response Block
    os.system("sed -i '' 's/DI_MS/method_source dakota/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_IT/interval_type forward/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_GS/fd_gradient_step_size = 0.00001/' " + RunDir + "/dakota.in")

elif OptMthd == 'optpp-ds':
    # DAKOTA Controls for input file Method Block
    os.system("sed -i '' 's/ DI_MTHD/optpp_pds/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_CT/convergence_tolerance = 1e-6/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_MI/max_iterations = 50000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_FE/max_function_evaluations = 100000/' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_SD/d' " + RunDir + "/dakota.in")
    os.system("sed -i '' '/DI_ID/d' " + RunDir + "/dakota.in")
    # DAKOTA Controls for input file Response Block
    os.system("sed -i '' 's/DI_MS/method_source dakota/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_IT/interval_type forward/' " + RunDir + "/dakota.in")
    os.system("sed -i '' 's/DI_GS/fd_gradient_step_size = 0.001/' " + RunDir + "/dakota.in")

#
# Done Inputting DAKOTA Optimization Method Controls
#

# Add selected parameters to list of optimization parameters
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
prm_cnt = 0
for ind, prm in enumerate(PN):
    if PC[ind]:
        os.system("sed -i '' \"/descriptors =/s/$/ \\'" + prm + "\\'/\" " + RunDir + "/dakota.in")
        os.system("sed -i '' '/initial_point =/s/$/ " + f"{PV_Norm[ind]:g}" + "/' " + RunDir + "/dakota.in")
        if OptMthd != 'optpp':
            os.system("sed -i '' '/lower_bounds =/s/$/ 0.0/' " + RunDir + "/dakota.in")
            os.system("sed -i '' '/upper_bounds =/s/$/ 1.0/' " + RunDir + "/dakota.in")

        prm_cnt +=1

os.system("sed -i '' '/continuous_design =/s/$/ " + str(prm_cnt) + "/' " + RunDir + "/dakota.in")

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
# Done setting up dakota.in                                     #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

# Output Information for interface.py
np.save(RunDir + "/PControls",np.array([PN,PC]))
np.save(RunDir + "/PValues", np.array([NV,LB,UB]))

# Run Dakota
os.chdir(RunDir)
os.system("time dakota -i dakota.in -o output.out -e error.err")
