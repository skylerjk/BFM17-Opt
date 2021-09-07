#!/bin/zsh

BFMCase=$1

param_bol=( `cat ../PrmBols.txt` )
param_val=( `cat ../PrmVals.txt` )

# p_PAR Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[1]}; then
# Parameter: p_PAR (Being Estimated)
p_PAR=$(( $param_val[1]*0.2+0.3 ))

else
# Parameter: p_PAR
p_PAR="0.4"


fi

# p_eps0 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[2]}; then
# Parameter: p_eps0 (Being Estimated)
p_eps0=$(( $param_val[2]*0.007+0.04 ))

else
# Parameter: p_eps0
p_eps0="0.0435"

fi

#p_epsR6 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[3]}; then
# Parameter: p_epsR6 (Being Estimated)
p_epsR6=$(( $param_val[3]*0.0001+0.0005 ))

else
# Parameter: p_epsR6
p_epsR6="0.1e-3"


fi

# p_pe_R1c Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[4]}; then
# Parameter: p_pe_R1c (Being Estimated)
p_pe_R1c=$(( $param_val[4]*0.5+0.5 ))

else
# Parameter: p_pe_R1c
p_pe_R1c="0.60"

fi

# p_pe_R1n Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[5]}; then
# Parameter: p_pe_R1n (Being Estimated)
p_pe_R1n=$(( $param_val[5]*0.5+0.5 ))

else
# Parameter: p_pe_R1n
p_pe_R1n="0.72"

fi

# p_pe_R1p Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[6]}; then
# Parameter: p_pe_R1p (Being Estimated)
p_pe_R1p=$(( $param_val[6]*0.5+0.5 ))

else
# Parameter: p_pe_R1p
p_pe_R1p="0.832"

fi


# p_sum Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[7]}; then
# Parameter: p_sum (Being Estimated)
p_sum=$(( $param_val[7]*3.0+1.0 ))

else
# Parameter: p_sum
p_sum="1.6"

fi

# p_srs Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[8]}; then
# Parameter: p_srs (Being Estimated)
p_srs=$(( $param_val[8]*0.05+0.025 ))

else
# Parameter: p_srs
p_srs="0.05"

fi

# p_sdmo Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[9]}; then
# Parameter: p_sdmo (Being Estimated)
p_sdmo=$(( $param_val[9]+0.05+0.025 ))

else
# Parameter: p_sdmo
p_sdmo="0.05"

fi

# p_thdo Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[10]}; then
# Parameter: p_thdo (Being Estimated)
p_thdo=$(( $param_val[10]*0.1+0.05 ))

else
# Parameter: p_thdo
p_thdo="0.1"

fi

# p_pu_ea Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[11]}; then
# Parameter: p_pu_ea (Being Estimated)
p_pu_ea=$(( $param_val[11]*0.05+0.025 ))

else
# Parameter: p_pu_ea
p_pu_ea="0.05"

fi

# p_pu_ra Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[12]}; then
# Parameter: p_pu_ra (Being Estimated)
p_pu_ra=$(( $param_val[12]*0.05+0.025 ))

else
# Parameter: p_pu_ra
p_pu_ra="0.05"

fi

# p_qun Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[13]}; then
# Parameter: p_qun (Being Estimated)
p_qun=$(( $param_val[13]*0.025+0.0125 ))

else
# Parameter: p_qun
p_qun="0.025"

fi

# p_lN4 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[14]}; then
# Parameter: p_lN4 (Being Estimated)
p_lN4=$(( $param_val[14]*2.0+1.0 ))

else
# Parameter: p_lN4
p_lN4="1.5"

fi

# p_qnlc Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[15]}; then
# Parameter: p_qnlc (Being Estimated)
p_qnlc=$(( $param_val[15]*0.00687+0.003435 ))

else
# Parameter: p_qnlc
p_qnlc="6.87e-3"

fi

# p_qncPPY Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[16]}; then
# Parameter: p_qncPPY (Being Estimated)
p_qncPPY=$(( $param_val[16]*0.0126+0.0063 ))

else
# Parameter: p_qncPPY
p_qncPPY="1.26e-2"

fi

# p_xqn Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[17]}; then
# Parameter: p_xqn (Being Estimated)
p_xqn=$(( $param_val[17]*1.0+1.0 ))

else
# Parameter: p_xqn
p_xqn="1.5"

fi

# p_qup Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[18]}; then
# Parameter: p_qup (Being Estimated)
p_qup=$(( $param_val[18]*0.0025+0.00125 ))

else
# Parameter: p_qup
p_qup="2.5e-3"

fi

# p_qplc Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[19]}; then
# Parameter: p_qplc (Being Estimated)
p_qplc=$(( $param_val[19]*0.000429+0.0002145 ))

else
# Parameter: p_qplc
p_qplc="4.29e-4"

fi

# p_qpcPPY Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[20]}; then
# Parameter: p_qpcPPY (Being Estimated)
p_qpcPPY=$(( $param_val[20]*0.000786+0.000393 ))

else
# Parameter: p_qpcPPY
p_qpcPPY="7.86e-4"

fi

# p_xqp Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[21]}; then
# Parameter: p_xqp (Being Estimated)
p_xqp=$(( $param_val[21]*1.0+1.0 ))

else
# Parameter: p_xqp
p_xqp="1.5"

fi

# p_esNI Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[22]}; then
# Parameter: p_esNI (Being Estimated)
p_esNI=$(( $param_val[22]*0.75+0.25 ))

else
# Parameter: p_esNI
p_esNI="0.75"

fi

# p_res Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[23]}; then
# Parameter: p_res (Being Estimated)
p_res=$(( $param_val[23]*0.5+0.25 ))

else
# Parameter: p_res
p_res="0.5"

fi

# p_alpha_chl Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[24]}; then
# Parameter: p_alpha_chl (Being Estimated)
p_alpha_chl=$(( $param_val[24]*0.0000152+0.0000076 ))

else
# Parameter: p_alpha_chl
p_alpha_chl="1.52e-5"

fi

# p_qlcPPY Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[25]}; then
# Parameter: p_qlcPPY (Being Estimated)
p_qlcPPY=$(( $param_val[26]*0.016+0.008 ))

else
# Parameter: p_qlcPPY
p_qlcPPY="0.016"
fi

# p_epsChla Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[26]}; then
# Parameter: p_epsChla (Being Estimated)
p_epsChla=$(( $param_val[26]*0.03+0.015 ))

else
# Parameter: p_epsChla
p_epsChla="0.03"

fi

# z_srs Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[27]}; then
# Parameter: z_srs (Being Estimated)
z_srs=$(( $param_val[27]*0.04+0.01 ))

else
# Parameter: z_srs
z_srs="0.02"

fi

# z_sum Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[28]}; then
# Parameter: z_sum (Being Estimated)
z_sum=$(( $param_val[28]*4.0+1.0 ))

else
# Parameter: z_sum
z_sum="2.0"

fi

# z_sdo Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[29]}; then
# Parameter: z_sdo (Being Estimated)
z_sdo=$(( $param_val[29]*0.25+0.125 ))

else
# Parameter: z_sdo
z_sdo="0.25"

fi

# z_sd Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[30]}; then
# Parameter: z_sd (Being Estimated)
z_sd=$(( $param_val[30]*0.05+0.025 ))

else
# Parameter: z_sd
z_sd="0.05"

fi

# z_pu Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[31]}; then
# Parameter: z_pu (Being Estimated)
z_pu=$(( $param_val[31]*0.5+0.25 ))

else
# z_pu
z_pu="0.5"

fi

# z_pu_ea Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[32]}; then
# Parameter: z_pu_ea (Being Estimated)
z_pu_ea=$(( $param_val[32]*0.25+0.125 ))

else
# Parameter: z_pu_ea
z_pu_ea="0.25"

fi

# z_chro Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[33]}; then
# Parameter: z_chro (Being Estimated)
z_chro=$(( $param_val[33]*0.5+0.25 ))

else
# Parameter: z_chro
z_chro="0.5"

fi

# z_chuc Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[34]}; then
# Parameter: z_chuc (Being Estimated)
z_chuc=$(( $param_val[34]*400.0+100.0 ))

else
# Parameter: z_chuc
z_chuc="200.0"

fi

# z_minfood Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[35]}; then
# Parameter: z_minfood (Being Estimated)
z_minfood=$(( $param_val[35]*50.0+25.0 ))

else
# Parameter: z_minfood
z_minfood="50.0"

fi

# z_qpcMIZ Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[36]}; then
# Parameter: z_qpcMIZ (Being Estimated)
z_qpcMIZ=$(( $param_val[36]*0.0002+0.0007 ))

else
# Parameter: z_qpcMIZ
z_qpcMIZ="7.862e-4"

fi

# z_qncMIZ Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
if ${param_bol[37]}; then
# Parameter: z_qncMIZ (Being Estimated)
z_qncMIZ=$(( $param_val[37]*0.01+0.01 ))

else
# Parameter: z_qncMIZ
z_qncMIZ="1.258e-2"

fi

# z_paPPY Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[38]}; then
# Parameter: z_paPPY (Being Estimated)
z_paPPY=$(( $param_val[38]*0.5+0.5 ))

else
# Parameter: z_paPPY
z_paPPY="1.0"

fi

# p_sN4N3 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[39]}; then
# Parameter: p_sN4N3 (Being Estimated)
p_sN4N3=$(( $param_val[39]*0.01+0.005 ))

else
# Parameter: p_sN4N3
p_sN4N3="0.01"

fi

# p_clO2o Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[40]}; then
# Parameter: p_clO2o (Being Estimated)
p_clO2o=$(( $param_val[40]*10.0+5.0 ))

else
# Parameter: p_clO2o
p_clO2o="10.0"

fi

# p_sR6O3 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[41]}; then
# Parameter: p_sR6O3 (Being Estimated)
p_sR6O3=$(( $param_val[41]*0.4+0.05 ))

else
# Parameter: p_sR6O3
p_sR6O3="0.1"

fi

# p_sR6N1 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[42]}; then
# Parameter: p_sR6N1 (Being Estimated)
p_sR6N1=$(( $param_val[42]*0.4+0.05 ))

else
# Parameter: p_sR6N1
p_sR6N1="0.1"

fi

# p_sR6N4 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[43]}; then
# Parameter: p_sR6N4 (Being Estimated)
p_sR6N4=$(( $param_val[43]*0.4+0.05 ))
#p_sR6N4=\`echo \$p_sR6N4'*0.4+0.05' | bc -l | sed -e 's/[0]*\$//'\`

else
# Parameter: p_sR6N4
p_sR6N4="0.1"
fi

# p_sR1O3 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[44]}; then
# Parameter: p_sR1O3 (Being Estimated)
p_sR1O3=$(( $param_val[44]*0.4+0.05 ))

else
# Parameter: p_sR1O3
p_sR1O3="0.05"

fi

# p_sR1N1 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[45]}; then
# Parameter: p_sR1N1 (Being Estimated)
p_sR1N1=$(( $param_val[45]*0.4+0.05 ))

else
# Parameter: p_sR1N1
p_sR1N1="0.05"

fi

# p_sR1N4 Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[46]}; then
# Parameter: p_sR1N4 (Being Estimated)
p_sR1N4=$(( $param_val[46]*0.4+0.05 ))

else
# Parameter: p_sR1N4
p_sR1N4="0.05"

fi

# p_rR6m= Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
if ${param_bol[47]}; then
# Parameter: p_rR6m (Being Estimated)
p_rR6m=$(( $param_val[47]*5.0+0.5 ))
#p_rR6m=\`echo \$p_rR6m'*5.0+0.5' | bc -l | sed -e 's/[0]*\$//'\`

else
# Parameter: p_rR6m
p_rR6m="1.0"

fi

################################################################################
# If running the case where BFM is coupled to POM, then there are additional
# parameters that need to be included in the interface script correspoinding to
# the boundary conditiions for the 1D case, not included in the 0D implementation
################################################################################
if [[ $BFMCase = '1D' ]]; then

# NRT_o2o Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  if ${param_bol[48]}; then
  # Parameter: NRT_o2o (Being Estimated)
  NRT_o2o=$(( $param_val[48]*0.5 ))

  else
    # Parameter: NRT_o2o
    NRT_o2o="0.06"

  fi

# NRT_n1p Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  if ${param_bol[49]}; then
  # Parameter: NRT_n1p (Being Estimated)
    NRT_n1p=$(( $param_val[49]*0.5 ))

  else
    # Parameter: NRT_n1p
    NRT_n1p="0.06"

  fi

# NRT_n3n Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  if ${param_bol[50]}; then
  # Parameter: NRT_n3n (Being Estimated)
    NRT_n3n=$(( $param_val[50]*0.5 ))

  else
  # Parameter: NRT_n3n
    NRT_n3n="0.06"

  fi

# NRT_n4n Control -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  if ${param_bol[51]}; then
  # Parameter: NRT_n4n (Being Estimated)
    NRT_n4n=$(( $param_val[51]*0.5 ))

  else
  # Parameter: NRT_n4n
    NRT_n4n="0.05"

  fi

#End of IF statement for BFMCase = BFMPOM
fi


# ---------------------------------------------------------------------------- #
# PRE-PROCESSING - Writing Namelists
# ---------------------------------------------------------------------------- #
# Incorporate the rescaled parameters from initial perturbed normalized values
# into the initial model evaluation.
case $BFMCase in
  0D )
  # Case corresponding to the 0D implementation of the BFM17

  ./write_BFMGen.sh $p_pe_R1c $p_pe_R1n $p_pe_R1p
  ./write_PelEco.sh $p_sum $p_srs $p_sdmo $p_thdo $p_pu_ea \
                      $p_pu_ra $p_qun $p_lN4 $p_qnlc $p_qncPPY \
                      $p_xqn $p_qup $p_qplc $p_qpcPPY $p_xqp  $p_esNI \
                      $p_res $p_alpha_chl $p_qlcPPY $p_epsChla \
                      $z_srs $z_sum $z_sdo $z_sd $z_pu $z_pu_ea \
                      $z_chro $z_chuc $z_minfood $z_qpcMIZ $z_qncMIZ $z_paPPY
  ./write_PelEnv.sh $p_PAR $p_eps0 $p_epsR6 $p_sN4N3 $p_clO2o \
                      $p_sR6O3 $p_sR1O3 $p_sR6N1 $p_sR1N1 $p_sR6N4 $p_sR1N4 \
                      $p_rR6m

    ;; # End of case

  1D )
  # Case corresponding to the 1D implementation of BFM17 coupled to POM

  ./write_BFMGen.sh $p_PAR $p_eps0 $p_epsR6 $p_pe_R1c $p_pe_R1n $p_pe_R1p
  ./write_PelEco.sh $p_sum $p_srs $p_sdmo $p_thdo $p_pu_ea \
                        $p_pu_ra $p_qun $p_lN4 $p_qnlc $p_qncPPY \
                        $p_xqn $p_qup $p_qplc $p_qpcPPY $p_xqp $p_esNI \
                        $p_res $p_sdchl $p_alpha_chl $p_qlcPPY \
                        $p_epsChla \
                        $z_srs $z_sum $z_sdo $z_sd $z_pu $z_pu_ea \
                        $z_chro $z_chuc $z_minfood $z_qpcMIZ $z_qncMIZ $z_paPPY
  ./write_PelEnv.sh $p_sN4N3 $p_clO2o $p_sR6O3 $p_sR6N1 $p_sR6N4 $p_sR1O3 $p_sR1N1 \
                        $p_sR1N4 $p_rR6m
  ./write_params.sh $NRT_o2o $NRT_n1p $NRT_n3n $NRT_n4n

    ;; # End of case
esac
