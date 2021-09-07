#!/bin/zsh
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Reading Information for Parameter Estimization Case Definition file          #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Input file
IptFl=$1

ind=`grep -n 'RunDir' $IptFl | cut -d: -f1`
RunDir=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'RunDir = ' $RunDir

# Identify BFM Implementation for Optimzation
ind=`grep -n 'BFMCase' $IptFl | cut -d: -f1`
BFMCase=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'BFMCase = ' $BFMCase

# Identify the type of study to be run
ind=`grep -n 'OptCase' $IptFl | cut -d: -f1`
OptCase=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'OptCase = ' $OptCase

# Identify the optimization algorithm to use
ind=`grep -n 'OptMthd' $IptFl | cut -d: -f1`
OptMthd=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'OptMthd = ' $OptMthd

# Identify if running an initial evaluation of the model
ind=`grep -n 'PrtCase' $IptFl | cut -d: -f1`
PrtCase=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'PrtCase = ' $PrtCase

# Identify if running an initial evaluation of the model
ind=`grep -n 'InitRun' $IptFl | cut -d: -f1`
InitRun=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'InitRun = ' $InitRun

# Identify if running an ultimate evaluation of the model
ind=`grep -n 'PostRun' $IptFl | cut -d: -f1`
PostRun=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'PostRun = ' $PostRun

# Identify if normalizing by results from initial run of model
ind=`grep -n 'NormObj' $IptFl | cut -d: -f1`
NormObj=`head -$ind $IptFl | tail -1 | cut -d '=' -f2`

echo 'NormObj = ' $NormObj

# Set to run initial model if norm is asked for but initial model evaluation isn't
if ! $InitRun && $NormObj; then
  echo '# # #'
  echo 'Resetting InitRun to true to run inital evaluation of model for normalization'
  echo '# # #'
  InitRun=true
fi

# Set the number of parameters to read from input file
if [[ $BFMCase = '0D' ]]; then
  # The 0D implementation of BFM17 only has 47 parameters to include in
  # parameter estimation.
  NumPrm=47
elif [[ $BFMCase = '1D' ]]; then
  # The BFM17 + POM1D implementation as 51 parameters to be estimated,
  # additional parameters come from the bottom boundary condition.
  NumPrm=51
fi

# Read parameter information from input file
ind=`grep -n 'ParameterList' $IptFl | cut -d: -f1`
for i in {1..$NumPrm}
do
  line=(`head -$(( $ind+$i )) $IptFl |tail -1`)

  prms+=($line[2])
  prms_bl+=($line[3])
  prms_nm+=($line[4])
  prms_lb+=($line[5])
  prms_ub+=($line[6])
done

# Read information about the objective function formulation
ind=`grep -n 'ObjectiveList' $IptFl | cut -d: -f1`
for i in {1..21}
do
  line=(`head -$(( $ind+$i )) $IptFl |tail -1`)

  obj+=($line[1])
  obj_bl+=($line[2])

done

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Using information read from parameter estimation case definition control file
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

for i in {1..$NumPrm}
do
  prms_nr+=( $(( ($prms_nm[i]-$prms_lb[i])/($prms_ub[i]-$prms_lb[i]) )) )

  # Create list of parameters being estimated
  if $prms_bl[i]; then
    dk_prms+=( \'$prms[i]\' )
    dk_prms_lb+=( 0.0 )
    dk_prms_up+=( 1.0 )

    # Calc Perturbed Normalized Value
    # (upward or downward based on user selection)
    if [[ $PrtCase = 'up' ]]; then
      dk_prms_iv+=( $(($prms_nr[i]+0.1)) )
    elif [[ $PrtCase = 'dn' ]]; then
      dk_prms_iv+=( $(($prms_nr[i]-0.1)) )
    fi

    if (( $(echo "$dk_prms_iv[-1] > 1.0" |bc -l) )); then
      dk_prms_iv[-1]=$(( $dk_prms_iv[-1] - 1.0 ))

    elif (( $(echo "$dk_prms_iv[-1] < 0.0" |bc -l) )); then
      dk_prms_iv[-1]=$(( $dk_prms_iv[-1] + 1.0 ))

    fi
  fi

  # If running initial evaluation of the model, need the combined set of perturbed and
  # unperturbed values.
  if $InitRun; then
    if ! $prms_bl[i]; then
      prm_set+=( $prms_nr[i] )
    elif $prms_bl[i]; then
      prm_set+=( $dk_prms_iv[-1] )
    fi
  fi

done

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Identifying Source Files
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Set values depending on what model will be evaluated
if [[ $BFMCase = '0D' ]]; then
  echo 'running 0D model'
  MdlSrc=Source/Source-0D/Source-BFM0D
  OptSrc=Source/Source-0D/Source-0D_Opt
  RunSrc=Source/Source-0D/Source-0D_Run
elif [[ $BFMCase = '1D' ]]; then
  echo 'running 1D model'
  MdlSrc=Source/Source-1D/Source-BFMPOM
  OptSrc=Source/Source-1D/Source-1D_Opt
  RunSrc=Source/Source-1D/Source-1D_Run
fi

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# Setting Up Optimization
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

# Location of Case being run
RunDir=PE-Runs/$RunDir
# Location of the opt and src directory
OptDir=$RunDir/opt_dir
SrcDir=$RunDir/src_dir

# Combine Source code to set up case run directory
mkdir $RunDir
mkdir $OptDir
cp -r $MdlSrc $SrcDir

if $InitRun || $PostRun; then
  # Make Directory for running model evaluations
  EvlDir=$RunDir/evl_dir
  mkdir $EvlDir

  # Copy for calculating the reference obj fnct values into run directory
  cp -r $MdlSrc/Data $EvlDir

  # For BFM17+POM1D only,
  if [[ $BFMCase = '1D' ]]; then
    cp -r $MdlSrc/Inputs $EvlDir
  fi

  # Put files for parameter controls - values to calculate
  echo $prms_bl[@] > $RunDir/evl_dir/PrmBols.txt

fi

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
#                         For Initial Run of Model                             #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
if $InitRun; then
  RefCalc=true # create obj func calculator without normalization

  # Copy namelists into directory for an initial evaluation of the model
  cp -r $RunSrc $EvlDir/IEval

  cp Source/InitRunInterface.sh $EvlDir/IEval
  cp $OptSrc/write_* $EvlDir/IEval

  # Generate the objective function calculation script for initial Run
  ./write_ofunc.sh $EvlDir/IEval $BFMCase $NormObj $RefCalc $obj_bl[@]

  # Put files for parameter controls - use nominal value
  echo $prm_set[@] > $RunDir/evl_dir/PrmVals.txt

fi # End Initial Run Set-up

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
#                        For Subsequent Run of Model                           #
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
if $PostRun; then
  RefCalc=true # create obj func calculator without normalization

  cp -r $RunSrc $EvlDir/FEval

  cp Source/PostRunInterface.sh $EvlDir/FEval
  cp $OptSrc/write_* $EvlDir/FEval

  ./write_ofunc.sh $EvlDir/FEval $BFMCase $NormObj $RefCalc $obj_bl[@]

fi # End Subsequent Run Set-up

# Once done with setting up the initial/subsequent runs, if needed setting up
RefCalc=false # This means calculate normalized obj function if NormObj is true

echo '> > > Set Up DAKOTA Input File'
cp Source/dakota.in $OptDir

# # Edit the DAKOTA input file # #
# Put in the model specific information
sed -i '' "s/NUMPRMS/${#dk_prms[@]}/" $OptDir/dakota.in
sed -i '' "s/PRMS/$dk_prms[*]/" $OptDir/dakota.in
sed -i '' "s/IVAL/$dk_prms_iv[*]/" $OptDir/dakota.in
sed -i '' "s/LBND/$dk_prms_lb[*]/" $OptDir/dakota.in
sed -i '' "s/UBND/$dk_prms_up[*]/" $OptDir/dakota.in

# Put in the optimization options

# # For Testing MultiStart Approach # #
# multi_start
  # method_name = DI_MTHD
  # random_starts = 10
  # seed = 1001

  # sed -i '' "s/ DI_MTHD/\'conmin_frcg\'/" $OptDir/dakota.in

case $OptMthd in
  conmin )

  # Method Definitions
  sed -i '' "s/ DI_MTHD/conmin_frcg/" $OptDir/dakota.in
  sed -i '' "s/DI_CT/convergence_tolerance = 1e-6/" $OptDir/dakota.in
  # sed -i '' "s/CT/convergence_tolerance = 1e-8/" $OptDir/dakota.in
  sed -i '' "s/DI_MI/max_iterations = 1000/" $OptDir/dakota.in
  sed -i '' "/DI_FE/d" $OptDir/dakota.in
  sed -i '' "/DI_SD/d" $OptDir/dakota.in
  sed -i '' "/DI_ID/d" $OptDir/dakota.in
  # Response Definitions
  sed -i '' "s/DI_MS/method_source dakota/" $OptDir/dakota.in
  sed -i '' "s/DI_IT/interval_type central/" $OptDir/dakota.in
  sed -i '' "s/DI_GS/fd_gradient_step_size = 0.0001/" $OptDir/dakota.in


    ;;

  cobyla )

  # Method Definitions
  sed -i '' "s/DI_MTHD/coliny_cobyla/" $OptDir/dakota.in
  # convergence_tolerance is not used by COBYLA, instead set solution_target
  # sed -i '' "s/CT/solution_target = 1.e-6/" $OptDir/dakota.in
  sed -i '' "/DI_CT/d" $OptDir/dakota.in
  # max_iterations is ignored by COBYLA if set
  sed -i '' "/DI_MI/d" $OptDir/dakota.in
  # sed -i '' "s/FE/max_function_evaluations = 10000/" $OptDir/dakota.in
  sed -i '' "s/DI_FE/max_function_evaluations = 50000/" $OptDir/dakota.in
  sed -i '' "s/DI_SD/seed = 101/" $OptDir/dakota.in
  # sed -i '' "s/ID/initial_delta = 0.75/" $OptDir/dakota.in
  sed -i '' "/DI_ID/d" $OptDir/dakota.in
  # Response Definitions
  sed -i '' "s/numerical_gradients/no_gradients/" $OptDir/dakota.in
  sed -i '' "/DI_MS/d" $OptDir/dakota.in
  sed -i '' "/DI_IT/d" $OptDir/dakota.in
  sed -i '' "/DI_GS/d" $OptDir/dakota.in

    ;;

    *)

    echo 'OptMthd = ' $OptMthd ' is not a valid option, please change selection'

    ;;
esac

echo '> > > Set Up DAKOTA-BFM17 Interface Script'
./write_interface.sh $OptDir $BFMCase $prms_bl[@]
chmod +x $OptDir/interface.sh

# Set up templatedir
cp -r $RunSrc $OptDir/templatedir
cp $OptSrc/write_* $OptDir/templatedir

# Copy Reference Data into opt_dir
cp -r $MdlSrc/Data $OptDir

# For BFM17+POM1D, copy input data into opt_dir
if [[ $BFMCase = '1D' ]]; then
  cp -r $MdlSrc/Inputs $OptDir
fi

# Generate the objective function calculation script for optimization runs
echo '> > > Set Up Objective Function Calculator'
./write_ofunc.sh $OptDir/templatedir $BFMCase $NormObj $RefCalc $obj_bl[@]

#
# # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
# # Run Optimization
# # =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

cp OptCase.in $RunDir
cp $OptSrc/RunOptCase.sh $RunDir
cd $RunDir

echo '> > > Running Parameter Estimation Study'
./RunOptCase.sh $InitRun $PostRun $NormObj
