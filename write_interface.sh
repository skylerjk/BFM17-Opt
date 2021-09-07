#!/bin/zsh

# # # Description # # #
# This script takes as input DirNm, flnm_dkt, and flnm_mtl and generates the
# interface.sh script which serves as the bridge between DAKOTA and BFM17 /
# BFM17 + POM1D.

# Head Directory Name
DirNm=$1; shift
# BFMCASE: Switch between 0D and 1D cases
BFMCase=$1; shift

# Parameter Switches
param_bol=( $@ )

# Starting Index
Ind=2

# # # Writing interface.sh file header # # #
/bin/cat << EOF >$DirNm/interface.sh
#!/bin/zsh
# ---------------------------------------------------------------------------- #
# # #                     DAKOTA - BFM17 Interface                         # # #
# ---------------------------------------------------------------------------- #
# This script is the interface between DAKOTA and BFM17 + POM1D.
#
# There are three parts to performing each evaluation of the model.
# 1. Convert Parameter Value + Write Namelists
# 2. Run model
# 3. Calculate Obective function
#
# See Advanced Simulation Code Interfaces chapter in DAKOTA Users Manual
#
# --- Inputs to Script ---
# $1 is params.in FROM Dakota
# $2 is result.out returned to Dakota
#
# ---------------------------------------------------------------------------- #
# PRE-PROCESSING - Calculate Scaled Parameter Values
# ---------------------------------------------------------------------------- #
# This section is output to set the parameter(s) which are not included in the
# present parameter estimation run and to read and rescale the parameter(s)
# which are currently being estimated.

EOF


# # # Writing Parameter Controls # # #
# If a parameter is being included in the parameter estimation case, the read and
# interpret code is written to the interface script. Else, the nominal values is
# set.

# p_PAR Control
if ${param_bol[1]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_PAR (Being Estimated)
p_PAR=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_PAR=\`echo \$p_PAR | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_PAR=\`echo \$p_PAR'*0.2+0.3' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_PAR
p_PAR="0.4"

EOF
fi

# p_eps0="0.0435"
if ${param_bol[2]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_eps0 (Being Estimated)
p_eps0=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_eps0=\`echo \$p_eps0 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_eps0=\`echo \$p_eps0'*0.007+0.04' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_eps0
p_eps0="0.0435"

EOF
fi

#p_epsR6="0.1e-3"
if ${param_bol[3]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_epsR6 (Being Estimated)
p_epsR6=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_epsR6=\`echo \$p_epsR6 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_epsR6=\`echo \$p_epsR6'*0.0001+0.00005' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_epsR6
p_epsR6="0.1e-3"

EOF
fi

# p_pe_R1c="0.60"
if ${param_bol[4]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pe_R1c (Being Estimated)
p_pe_R1c=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_pe_R1c=\`echo \$p_pe_R1c | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_pe_R1c=\`echo \$p_pe_R1c'*0.5+0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pe_R1c
p_pe_R1c="0.60"

EOF
fi

# p_pe_R1n="0.72"
if ${param_bol[5]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pe_R1n (Being Estimated)
p_pe_R1n=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_pe_R1n=\`echo \$p_pe_R1n | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_pe_R1n=\`echo \$p_pe_R1n'*0.5+0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pe_R1n
p_pe_R1n="0.72"

EOF
fi

# p_pe_R1p="0.832"
if ${param_bol[6]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pe_R1p (Being Estimated)
p_pe_R1p=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_pe_R1p=\`echo \$p_pe_R1p | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_pe_R1p=\`echo \$p_pe_R1p'*0.5+0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pe_R1p
p_pe_R1p="0.832"

EOF
fi


# p_sum="1.6"
if ${param_bol[7]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sum (Being Estimated)
p_sum=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sum=\`echo \$p_sum | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sum=\`echo \$p_sum'*3.0+1.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sum
p_sum="1.6"

EOF
fi

# p_srs="0.05"
if ${param_bol[8]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_srs (Being Estimated)
p_srs=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_srs=\`echo \$p_srs | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_srs=\`echo \$p_srs'*0.05+0.025' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_srs
p_srs="0.05"

EOF
fi

# p_sdmo="0.05"
if ${param_bol[9]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sdmo (Being Estimated)
p_sdmo=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sdmo=\`echo \$p_sdmo | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sdmo=\`echo \$p_sdmo'*0.05+0.025' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sdmo
p_sdmo="0.05"

EOF
fi

# p_thdo="0.1"
if ${param_bol[10]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_thdo (Being Estimated)
p_thdo=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_thdo=\`echo \$p_thdo | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_thdo=\`echo \$p_thdo'*0.1+0.05' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_thdo
p_thdo="0.1"

EOF
fi

# p_pu_ea="0.05"
if ${param_bol[11]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pu_ea (Being Estimated)
p_pu_ea=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_pu_ea=\`echo \$p_pu_ea | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_pu_ea=\`echo \$p_pu_ea'*0.05+0.025' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pu_ea
p_pu_ea="0.05"

EOF
fi

# p_pu_ra="0.05"
if ${param_bol[12]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pu_ra (Being Estimated)
p_pu_ra=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_pu_ra=\`echo \$p_pu_ra | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_pu_ra=\`echo \$p_pu_ra'*0.05+0.025' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_pu_ra
p_pu_ra="0.05"

EOF
fi

# p_qun="0.025"
if ${param_bol[13]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qun (Being Estimated)
p_qun=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_qun=\`echo \$p_qun | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_qun=\`echo \$p_qun'*0.025+0.0125' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qun
p_qun="0.025"

EOF
fi

# p_lN4="1.5"
if ${param_bol[14]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_lN4 (Being Estimated)
p_lN4=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_lN4=\`echo \$p_lN4 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_lN4=\`echo \$p_lN4'*2.0+1.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_lN4
p_lN4="1.5"

EOF
fi

# p_qnlc="6.87e-3"
if ${param_bol[15]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qnlc (Being Estimated)
p_qnlc=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_qnlc=\`echo \$p_qnlc | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_qnlc=\`echo \$p_qnlc'*0.00687+0.003435' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qnlc
p_qnlc="6.87e-3"

EOF
fi

# p_qncPPY="1.26e-2"
if ${param_bol[16]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qncPPY (Being Estimated)
p_qncPPY=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_qncPPY=\`echo \$p_qncPPY | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_qncPPY=\`echo \$p_qncPPY'*0.0126+0.0063' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qncPPY
p_qncPPY="1.26e-2"

EOF
fi

# p_xqn="1.5"
if ${param_bol[17]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_xqn (Being Estimated)
p_xqn=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_xqn=\`echo \$p_xqn | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_xqn=\`echo \$p_xqn'*1.0+1.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_xqn
p_xqn="1.5"

EOF
fi

# p_qup="2.5e-3"
if ${param_bol[18]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qup (Being Estimated)
p_qup=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_qup=\`echo \$p_qup | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_qup=\`echo \$p_qup'*0.0025+0.00125' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qup
p_qup="2.5e-3"

EOF
fi

# p_qplc="4.29e-4"
if ${param_bol[19]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qplc (Being Estimated)
p_qplc=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_qplc=\`echo \$p_qplc | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_qplc=\`echo \$p_qplc'*0.000429+0.0002145' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qplc
p_qplc="4.29e-4"

EOF
fi

# p_qpcPPY="7.86e-4"
if ${param_bol[20]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qpcPPY (Being Estimated)
p_qpcPPY=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_qpcPPY=\`echo \$p_qpcPPY | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_qpcPPY=\`echo \$p_qpcPPY'*0.000786+0.000393' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qpcPPY
p_qpcPPY="7.86e-4"

EOF
fi

# p_xqp="1.5"
if ${param_bol[21]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_xqp (Being Estimated)
p_xqp=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_xqp=\`echo \$p_xqp | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_xqp=\`echo \$p_xqp'*1.0+1.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_xqp
p_xqp="1.5"

EOF
fi

# p_esNI="0.75"
if ${param_bol[22]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_esNI (Being Estimated)
p_esNI=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_esNI=\`echo \$p_esNI | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_esNI=\`echo \$p_esNI'*0.75+0.25' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_esNI
p_esNI="0.75"

EOF
fi

# p_res="0.5"
if ${param_bol[23]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_res (Being Estimated)
p_res=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_res=\`echo \$p_res | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_res=\`echo \$p_res'*0.5+0.25' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_res
p_res="0.5"

EOF
fi

# p_alpha_chl="1.52e-5"
if ${param_bol[24]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_alpha_chl (Being Estimated)
p_alpha_chl=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_alpha_chl=\`echo \$p_alpha_chl | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_alpha_chl=\`echo \$p_alpha_chl'*0.0000152+0.0000076' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_alpha_chl
p_alpha_chl="1.52e-5"

EOF
fi

# p_qlcPPY="0.016"
if ${param_bol[25]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qlcPPY (Being Estimated)
p_qlcPPY=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_qlcPPY=\`echo \$p_qlcPPY | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_qlcPPY=\`echo \$p_qlcPPY'*0.016+0.008' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_qlcPPY
p_qlcPPY="0.016"
EOF
fi

# p_epsChla="0.03"
if ${param_bol[26]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_epsChla (Being Estimated)
p_epsChla=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_epsChla=\`echo \$p_epsChla | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_epsChla=\`echo \$p_epsChla'*0.03+0.015' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_epsChla
p_epsChla="0.03"

EOF
fi

# z_srs="0.02"
if ${param_bol[27]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_srs (Being Estimated)
z_srs=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_srs=\`echo \$z_srs | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_srs=\`echo \$z_srs'*0.04+0.01' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_srs
z_srs="0.02"

EOF
fi

# z_sum="2.0"
if ${param_bol[28]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_sum (Being Estimated)
z_sum=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_sum=\`echo \$z_sum | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_sum=\`echo \$z_sum'*4.0+1.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_sum
z_sum="2.0"

EOF
fi

# z_sdo="0.25"
if ${param_bol[29]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_sdo (Being Estimated)
z_sdo=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_sdo=\`echo \$z_sdo | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_sdo=\`echo \$z_sdo'*0.25+0.125' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_sdo
z_sdo="0.25"

EOF
fi

# z_sd="0.05"
if ${param_bol[30]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_sd (Being Estimated)
z_sd=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_sd=\`echo \$z_sd | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_sd=\`echo \$z_sd'*0.05+0.025' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_sd
z_sd="0.05"

EOF
fi

# z_pu="0.5"
if ${param_bol[31]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_pu (Being Estimated)
z_pu=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_pu=\`echo \$z_pu | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_pu=\`echo \$z_pu'*0.5+0.25' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# z_pu
z_pu="0.5"

EOF
fi

# z_pu_ea="0.25"
if ${param_bol[32]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_pu_ea (Being Estimated)
z_pu_ea=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_pu_ea=\`echo \$z_pu_ea | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_pu_ea=\`echo \$z_pu_ea'*0.25+0.125' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_pu_ea
z_pu_ea="0.25"

EOF
fi

# z_chro="0.5"
if ${param_bol[33]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_chro (Being Estimated)
z_chro=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_chro=\`echo \$z_chro | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_chro=\`echo \$z_chro'*0.5+0.25' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_chro
z_chro="0.5"

EOF
fi

# z_chuc="200.0"
if ${param_bol[34]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_chuc (Being Estimated)
z_chuc=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_chuc=\`echo \$z_chuc | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_chuc=\`echo \$z_chuc'*400.0+100.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_chuc
z_chuc="200.0"

EOF
fi

# z_minfood="50.0"
if ${param_bol[35]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_minfood (Being Estimated)
z_minfood=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_minfood=\`echo \$z_minfood | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_minfood=\`echo \$z_minfood'*50.0+25.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_minfood
z_minfood="50.0"

EOF
fi

# z_qpcMIZ="7.862e-4"
if ${param_bol[36]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_qpcMIZ (Being Estimated)
z_qpcMIZ=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_qpcMIZ=\`echo \$z_qpcMIZ | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_qpcMIZ=\`echo \$z_qpcMIZ'*0.0002+0.0007' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_qpcMIZ
z_qpcMIZ="7.862e-4"

EOF
fi

# z_qncMIZ="1.258e-2"
if ${param_bol[37]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_qncMIZ (Being Estimated)
z_qncMIZ=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_qncMIZ=\`echo \$z_qncMIZ | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_qncMIZ=\`echo \$z_qncMIZ'*0.01+0.01' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_qncMIZ
z_qncMIZ="1.258e-2"

EOF
fi

# z_paPPY="1.0"
if ${param_bol[38]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_paPPY (Being Estimated)
z_paPPY=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
z_paPPY=\`echo \$z_paPPY | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
z_paPPY=\`echo \$z_paPPY'*0.5+0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: z_paPPY
z_paPPY="1.0"

EOF
fi

# p_sN4N3="0.01"
if ${param_bol[39]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sN4N3 (Being Estimated)
p_sN4N3=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sN4N3=\`echo \$p_sN4N3 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sN4N3=\`echo \$p_sN4N3'*0.01+0.005' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sN4N3
p_sN4N3="0.01"

EOF
fi

# p_clO2o="10.0"
if ${param_bol[40]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_clO2o (Being Estimated)
p_clO2o=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_clO2o=\`echo \$p_clO2o | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_clO2o=\`echo \$p_clO2o'*10.0+5.0' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_clO2o
p_clO2o="10.0"

EOF
fi

# p_sR6O3="0.1"
if ${param_bol[41]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR6O3 (Being Estimated)
p_sR6O3=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sR6O3=\`echo \$p_sR6O3 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sR6O3=\`echo \$p_sR6O3'*0.4+0.05' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR6O3
p_sR6O3="0.1"

EOF
fi

# p_sR6N1="0.1"
if ${param_bol[42]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR6N1 (Being Estimated)
p_sR6N1=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sR6N1=\`echo \$p_sR6N1 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sR6N1=\`echo \$p_sR6N1'*0.4+0.05' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR6N1
p_sR6N1="0.1"

EOF
fi

# p_sR6N4="0.1"
if ${param_bol[43]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR6N4 (Being Estimated)
p_sR6N4=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sR6N4=\`echo \$p_sR6N4 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sR6N4=\`echo \$p_sR6N4'*0.4+0.05' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR6N4
p_sR6N4="0.1"

EOF
fi

# p_sR1O3="0.05"
if ${param_bol[44]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR1O3 (Being Estimated)
p_sR1O3=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sR1O3=\`echo \$p_sR1O3 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sR1O3=\`echo \$p_sR1O3'*0.4+0.05' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR1O3
p_sR1O3="0.05"

EOF
fi

# p_sR1N1="0.05"
if ${param_bol[45]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR1N1 (Being Estimated)
p_sR1N1=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sR1N1=\`echo \$p_sR1N1 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sR1N1=\`echo \$p_sR1N1'*0.4+0.05' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR1N1
p_sR1N1="0.05"

EOF
fi

# p_sR1N4="0.05"
if ${param_bol[46]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR1N4 (Being Estimated)
p_sR1N4=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_sR1N4=\`echo \$p_sR1N4 | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_sR1N4=\`echo \$p_sR1N4'*0.4+0.05' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_sR1N4
p_sR1N4="0.05"

EOF
fi

# p_rR6m="1.0"
if ${param_bol[47]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_rR6m (Being Estimated)
p_rR6m=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
p_rR6m=\`echo \$p_rR6m | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
p_rR6m=\`echo \$p_rR6m'*5.0+0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: p_rR6m
p_rR6m="1.0"

EOF
fi

################################################################################
# If running the case where BFM is coupled to POM, then there are additional
# parameters that need to be included in the interface script correspoinding to
# the boundary conditiions for the 1D case, not included in the 0D implementation
################################################################################
if [[ $BFMCase = '1D' ]]; then

# NRT_o2o="0.06"
if ${param_bol[48]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_o2o (Being Estimated)
NRT_o2o=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
NRT_o2o=\`echo \$NRT_o2o | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
NRT_o2o=\`echo \$NRT_o2o'*0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_o2o
NRT_o2o="0.06"

EOF
fi

# NRT_n1p="0.06"
if ${param_bol[49]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_n1p (Being Estimated)
NRT_n1p=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
NRT_n1p=\`echo \$NRT_n1p | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
NRT_n1p=\`echo \$NRT_n1p'*0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_n1p
NRT_n1p="0.06"

EOF
fi

# NRT_n3n="0.06"
if ${param_bol[50]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_n3n (Being Estimated)
NRT_n3n=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
NRT_n3n=\`echo \$NRT_n3n | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
NRT_n3n=\`echo \$NRT_n3n'*0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_n3n
NRT_n3n="0.06"

EOF
fi

# NRT_n4n="0.05"
if ${param_bol[51]}; then
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_n4n (Being Estimated)
NRT_n4n=\`head -$Ind \$1 | tail -1 | cut -d'=' -f2\`
NRT_n4n=\`echo \$NRT_n4n | sed -e 's/[eE]+*/\*10\^/' -e 's/}//'\`
NRT_n4n=\`echo \$NRT_n4n'*0.5' | bc -l | sed -e 's/[0]*\$//'\`

EOF
Ind=$(($Ind+1))

else
/bin/cat << EOF >>$DirNm/interface.sh
# Parameter: NRT_n4n
  NRT_n4n="0.05"

EOF
fi
#End of IF statement for BFMCASE = BFMPOM
fi


# # # Concluding interface.sh script # # #
# This section writes the code to run the scripts which generate the namelists
# based off the parameter values set or interpreted by the code in the previous
# section.

case $BFMCase in
  0D )
  # Case corresponding to the 0D implementation of the BFM17
/bin/cat << EOF >>$DirNm/interface.sh
# ---------------------------------------------------------------------------- #
# PRE-PROCESSING
# ---------------------------------------------------------------------------- #
# Incorporate the rescaled parameters from DAKOTA into the template input files.

./write_BFMGen.sh \$p_pe_R1c \$p_pe_R1n \$p_pe_R1p
./write_PelEco.sh \$p_sum \$p_srs \$p_sdmo \$p_thdo \$p_pu_ea \\
                      \$p_pu_ra \$p_qun \$p_lN4 \$p_qnlc \$p_qncPPY \\
                      \$p_xqn \$p_qup \$p_qplc \$p_qpcPPY \$p_xqp  \$p_esNI \\
                      \$p_res \$p_alpha_chl \$p_qlcPPY \$p_epsChla \\
                      \$z_srs \$z_sum \$z_sdo \$z_sd \$z_pu \$z_pu_ea \\
                      \$z_chro \$z_chuc \$z_minfood \$z_qpcMIZ \$z_qncMIZ \$z_paPPY
./write_PelEnv.sh \$p_PAR \$p_eps0 \$p_epsR6 \$p_sN4N3 \$p_clO2o \\
                  \$p_sR6O3 \$p_sR1O3 \$p_sR6N1 \$p_sR1N1 \$p_sR6N4 \$p_sR1N4 \\
                  \$p_rR6m
# --------
# ANALYSIS
# --------
# Run the BFM17+POM1D executable with the current set of input files.
bfm_standalone.x

# ---------------
# POST-PROCESSING
# ---------------
# Use MATLAB to calculate the objective function and output it to result.out.
/Applications/MATLAB_R2020b.app/bin/matlab -nodisplay -nosplash -nodesktop -nojvm -r "run('CalcObjective.m'); exit;"
EOF
    ;; # End of case

  1D )
  # Case corresponding to the 1D implementation of BFM17 coupled to POM
/bin/cat << EOF >>$DirNm/interface.sh
# ---------------------------------------------------------------------------- #
# PRE-PROCESSING - Writing Namelists
# ---------------------------------------------------------------------------- #
# Incorporate the rescaled parameters from DAKOTA into the template input files.

./write_BFMGen.sh \$p_PAR \$p_eps0 \$p_epsR6 \$p_pe_R1c \$p_pe_R1n \$p_pe_R1p
./write_PelEco.sh \$p_sum \$p_srs \$p_sdmo \$p_thdo \$p_pu_ea \\
                        \$p_pu_ra \$p_qun \$p_lN4 \$p_qnlc \$p_qncPPY \\
                        \$p_xqn \$p_qup \$p_qplc \$p_qpcPPY \$p_xqp \$p_esNI \\
                        \$p_res \$p_sdchl \$p_alpha_chl \$p_qlcPPY \\
                        \$p_epsChla \\
                        \$z_srs \$z_sum \$z_sdo \$z_sd \$z_pu \$z_pu_ea \\
                        \$z_chro \$z_chuc \$z_minfood \$z_qpcMIZ \$z_qncMIZ \$z_paPPY
./write_PelEnv.sh \$p_sN4N3 \$p_clO2o \$p_sR6O3 \$p_sR6N1 \$p_sR6N4 \$p_sR1O3 \$p_sR1N1 \\
                        \$p_sR1N4 \$p_rR6m
./write_params.sh \$NRT_o2o \$NRT_n1p \$NRT_n3n \$NRT_n4n

# --------
# ANALYSIS
# --------
# Run the BFM17+POM1D executable with the current set of input files.
pom.exe

# ---------------
# POST-PROCESSING
# ---------------
# Use python3 to calculate the objective function and output it to result.out.
python3 CalcObjective.py
EOF

    ;; # End of case
esac
