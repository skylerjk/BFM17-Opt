#!/bin/bash

# Exprement Control - 
# tseb : Twin Simulation Experiement using BATS data
# bats : using BATS model implementation
# hots : using HOTS model implementation
# comb : multi-site run for BATS + HOTS implementations    
PrmsIn="ParametersV4/Parameters51P.in"
PrmDir="SampleDataSet/BATS-51-PV4-set2"
ExpTyp="opt"
Exprmt="bats"
NormON="True"

# Submit Job Controls
JobQu="economy"
TimHH=12
TimMM=00
NumNd=02
NumCP=26

# Home Directory
HomDir="$(pwd)"

HeadDir="ORuns/BATS-51P-NrmWrSTD-5Fld-PV4-set2"
mkdir $HeadDir

cp -r $PrmDir $HeadDir/ParameterSets
cp Source/RunOptCases.sh $HeadDir

# for SR in {0..9}
for SR in {10..19}
do
  # Job ID
  JobID="OB51-S$SR"

  # Run Directory
  RunDir="$HeadDir/OptRun-SampleSet$SR"
  # Directory - Sampled parameter value input location
  SmpDir="../ParameterSets/PrmVals_Set$SR.npy"

  # Make Run Directory
  mkdir $RunDir

  # Put Run Files into Directory
  cp RunOpt.py $RunDir
  cp $PrmsIn $RunDir/Parameters.in

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
#PBS -A UCHS0001
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

python3 RunOpt.py $ExpTyp $Exprmt $NormON rSTD True \\
        $HomDir \\
        $SmpDir
EOF

  cp SubmitPBS.sh ResubmitPBS.sh
  sed -i'' '20,30d' ResubmitPBS.sh
  echo 'dakota -i dakota.in -o output.out -e error.err -r dakota.rst' >> ResubmitPBS.sh 


  qsub SubmitPBS.sh
  
  #
  cd $HomDir


done


