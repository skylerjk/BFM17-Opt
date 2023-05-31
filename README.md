# Automatic Parameter Estimation of the 17 State Variable Biogeochemical Flux Model (BFM17)

This code has everything that is needed to perform an optimization of the Biogeochemical Flux Model with 17 state variables (BFM17) coupled to the 1D Princeton Ocean Model using the DAKOTA numberical toolbox. The methodology suggested in the work this code supports has three steps: (1) the parameter space is randomly sampled, (2) the N_top best parameter sets are used to initialize local gradient based optimization runs, and (3) the best optimized case is used as our final optimized solution. The code here is able to run the random sampling using random hypercube sampling provided by DAKOTA and running the optimization using a quasi-Newton optimization algorithm from the OPT++ library in the code. 

Note that much of this work was run on a supercomputer so the work was initialized using the submit script Submit.sh. Run the program using the command:

>> ./Submit.sh

To run this you will need to have an environment set up to run the set-up script, DAKOTA, the interface, and BFM17+POM1D. The set-up, interface, and objective function calculator are written in python. Your python environment will require the numpy, os, sys, random, and netCDF libraries. DAKOTA will need to be downloaded and compiled so it can be called using the command 'dakota' or the command will need to be updated in RunOpt.py. As part of the set-up BFM17+POM1D is compiled producing an executable that can be run in the local environment. For BFM17+POM1D to be successfully compiled, you need to have the GNU Fortran compiler (set FD and LD in Source/Source-BFMPOM/compilers/gfortran.inc to the local command if not gfortran), OpenMPI, and NetCDF.

When run the setup script RunOpt.py reads the case that you would like to run from command line inputs provided to python in the submit files. They can edited in the preface to the code. The input options include:

1. RunDir : Path to a run directory
2. Proc : Procedure is either sampling (smp) or optimizing (opt)
3. Exprmt : Experiment is set to osse, bats, hots, or comb ( NomVals / SmpVals )
4. PrmVal : Baseline parameter values are either nominal or from sampled set 
5. NormObj : Switch for Normalizing Objective Function (True/False) 
6. NormVal : Normalization value 
7. MltStrt : Switch for running multi-start optimizaiton run (True/False)

The run directory is made while setting up the case based on the directory path provided by RunDir so it should not be an existing directory. The Exprmt controls the experiment being run, while Proc controls the procedure being used. The experiments that can be run are a twin simulation experiment (osse) case, the Bermuda Atlantic Time Series or Hawaii Ocean time-series implementaitons of BFM17+POM1D, or a combined case using BATS and HOTS simulations simultaneously. The twin simulation uses the BATS implementation of the model. The available procedures are sampling (smp) and optimization (opt). The objective function is calculated using scripts provided in Source/ObjFuncts/ in both procedures. The objective functions are set up to calculate the RMSD between model output data and observational/reference data. The field specific RMSD values should be noralized before summing across state variables, but this can be toggled using NormObj. The normalization values are calculated using the scripts in Source/NrmFuncts/ which are currectly set to be either the standard diviation of the reference field (rSTD) or the initial RMSD of a reference run of the model (RMSD). 

The user controls what is run by changing the relevent options or the relevent scripts. There is also an input file with the parameters and their nominal value, lower bound and upper bound. Each parameter has a control switch (True/False) which is toggled to include or exclude the parameter from the sampling/optimzation run. The location of this file is also provided needs to be set in the submit file. 

The user may find it useful to have a general idea of the content of this directory. The source code for BFM17+POM1D used to compile model and produce the executable is in Source/Source-BFMPOM. Input data for the two site implementations of the model are provided in Source/input_bats and Source/input_hots. The observational fields used as reference data for calculating the objective functions for the non-osse experiments is included in Source/ObsBATS and Source/ObsHOTS. A model run directory with template namelists used to feed parameter values to the model is included in Source/Source-Run. DAKOTA is set up using the an input file. The template input file is copied from Source/dakota.in and manipulated by RunOpt.py. The interface between DAKOTA and BFM17+POM1D is the python script Source/interface.py. 

In the subdirectory SampleDataSet, the code used to identify the 10 best parameter sets from the sampling step is included. The comparison is run using the command: 

>> python SamplingResults.py

