/bin/cat << EOF >params_POMBFM.nml
&Params_POMBFM
H       =  150.
DTI     =  3600.
ALAT    =  45.
IDIAGN  =  1
IDAYS   =  30
SMOTH   =  0.1
IHOTST  =  0
KL1     =  2
KL2     =  150
SAVEF   =  1
NRT_o2o =  $1
NRT_n1p =  $2
NRT_n3n =  $3
NRT_n4n =  $4
NBCT    =  2
NBCS    =  1
NBCBFM  =  1
UMOL    =  1.e-6
UMOLT   =  1.e-7
UMOLS   =  1.3e-7
UMOLBFM =  1.e-4
NTP     =  2
TRT     =  0
SRT     =  1
UPPERH  =  5.0
SSRT    =  5.68
/

EOF
