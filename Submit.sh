#!/bin/bash

# Job Controls
JobID="SmpB-BGC3"
JobQu="economy"
TimHH=12
TimMM=00
NumNd=03
NumCP=36

# Exprement Control - 
# tseb : Twin Simulation Experiement using BATS data
# bats : using BATS model implementation
# hots : using HOTS model implementation
# comb : multi-site run for BATS + HOTS implementations
# Experiment Type -
# smp : sampling
# opt : optimization 
PrmsIn="Parameters/Parameters_BGC-PO.in"
CoefIn="Parameters/WEddyPerts-BATS.in"
ExpTyp="smp"
Exprmt="bats"
NormON="True"

# Run Directory
# RunDir='TSE/TSE-Opt-NrmWrSTD-5Fld-BGC3c-Baseline'
RunDir='SmpRun/BATS-NrmWrSTD-5Fld-BGC3-BATSPhy'
# Directory - Sampled parameter value input location
SmpDir='NA'
# Home Directory
HomDir="$(pwd)"

# Make Run Directory
mkdir $RunDir

# Put Run Files into Directory
cp RunOpt.py $RunDir
cp $PrmsIn $RunDir/Parameters.in
cp $CoefIn $RunDir/WEddyPerts.in

# Copy source code to compile BFM17 + POM1D
cp -r Source/Source-BFMPOM $RunDir/Config
# Create template folder for Optimization
cp -r Source/Source-Run $RunDir/Source

cp Source/dakota.in $RunDir
cp Source/interface.py $RunDir/Source

# Copy objective function calculator to template directory
cp Source/ObjFncts/CalcObjective_$Exprmt.py $RunDir/Source/CalcObjective.py
if (($NormON=="True"))
then 
  cp Source/NrmFuncts/CalcNormVals_$Exprmt.py $RunDir/CalcNormVals.py
fi

cp Source/RunSol.py $RunDir

# Go to Run Directory
cd $RunDir

cat > SubmitPBS.sh << EOF
#!/bin/bash

#PBS -N $JobID
#PBS -A 
#PBS -q $JobQu
#PBS -l walltime=$TimHH:$TimMM:00
#PBS -l select=$NumNd:ncpus=$NumCP:mpiprocs=$NumCP

module purge
module load gnu
module load openmpi
module load netcdf

module load conda
conda activate OptEnv

PATH=\$PATH:/glade/u/home/skylerk/dakota/bin/
LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$NETCDF/lib

# Entry 1: Procedure - smp (Sampling), opt (Optimization)
# Entry 2: Exprement - see above
# Entry 3: Normalize RMSD - True/False
# Entry 4: Normalization - rSTD/RMSD/othr
# Entry 5: Sample Values - True/False (False runs with nominal values)
# Entry 6: Run Directory
# Entry 7: Sampled Values File

python3 RunOpt.py $ExpTyp $Exprmt $NormON rSTD False \\
        $HomDir \\
        $SmpDir
EOF

cp SubmitPBS.sh ResubmitPBS.sh
sed -i'' '20,30d' ResubmitPBS.sh
echo 'dakota -i dakota.in -o output.out -e error.err -r dakota.rst' >> ResubmitPBS.sh 


qsub SubmitPBS.sh
