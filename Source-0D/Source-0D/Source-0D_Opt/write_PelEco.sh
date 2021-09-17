/bin/cat << EOF >Pelagic_Ecology.nml
! Pelagic Bacteria Parameter Namelist !
!-------------------------------------------------------------------------!
&PelBacteria_parameters
!                           B1
    p_version            =  1
    p_q10                =  2.95
    p_chdo               =  30.0
    p_sd                 =  0.1
    p_sd2                =  0.0
    p_suhR1              =  0.3
    p_sulR1              =  0.0
    p_suR2               =  0.0
    p_suR3               =  0.0
    p_suR6               =  0.01
    p_sum                =  8.38
    p_pu_ra              =  0.6
    p_pu_ra_o            =  0.2
    p_srs                =  0.01
    p_qncPBA             =  0.0167
    p_qpcPBA             =  0.00185
    p_qlnc               =  0.0167
    p_qlpc               =  0.00185
    p_qun                =  0.0
    p_qup                =  0.0
    p_chn                =  5.00
    p_chp                =  1.00
    p_rec                =  1.0
    p_ruen               =  1.0
    p_ruep               =  1.0
    p_pu_ea_R3           =  0.0
/

! Phytoplankton Parameter Namelist !
!-------------------------------------------------------------------------!
&Phyto_parameters
!                     P1        P2        P3        P4
    p_q10          =  2.0       2.0       2.0       2.0
    p_temp         =  0.0       0.0       0.75      0.0
    p_sum          =  2.0       $1       3.0       0.75
    p_srs          =  0.01      $2      0.1       0.1
    p_sdmo         =  0.05      $3      0.05      0.0
    p_thdo         =  0.1       $4       0.1       0.1
    p_seo          =  0.0       0.0       0.0       0.0
    p_sheo         =  0.0       0.0       0.0       100.0
    p_pu_ea        =  0.05      $5      0.2       0.05
    p_pu_ra        =  0.1       $6      0.25      0.1
    p_switchDOC    =  1         1         1         1
    p_netgrowth    =  .FALSE.   .FALSE.   .FALSE.   .FALSE.
    p_limnut       =  1         1         1         1
    p_qun          =  0.025     $7     0.25      0.025
    p_lN4          =  1.0       $8       0.0       1.0
    p_qnlc         =  4.193e-3  $9  4.193e-3  0.00687
EOF
shift 9
/bin/cat << EOF >>Pelagic_Ecology.nml
    p_qncPPY       =  1.26e-2   $1   1.26e-2   1.26e-2
    p_xqn          =  2.0       $2       2.0       2.0
    p_qup          =  0.025     $3    0.25      0.025
    p_qplc         =  1.80e-4   $4   1.80e-4   4.29e-4
    p_qpcPPY       =  7.86e-4   $5   7.86e-4   7.86e-4
    p_xqp          =  2.0       $6       2.0       2.0
    p_switchSi     =  1         0         0         0
    p_chPs         =  1.0       0.0       0.0       0.0
    p_Contois      =  0.0       0.0       0.0       0.0
    p_qus          =  0.0       0.0       0.0       0.0
    p_qslc         =  0.0       0.0       0.0       0.0
    p_qscPPY       =  0.01      0.0       0.0       0.0
    p_esNI         =  0.1       $7      0.00      0.00
    p_res          =  5.0       $8       0.0       0.0
    p_switchChl    =  1         3         1         1
    p_sdchl        =  0.2       0.2       0.2       0.2
    p_alpha_chl    =  1.38e-5   $9   1.52e-5   0.68e-5
EOF
shift 9
/bin/cat << EOF >>Pelagic_Ecology.nml
    p_qlcPPY       =  0.025     $1     0.02      0.02
    p_epsChla      =  0.03      $2      0.03      0.03
    p_EpEk_or      =  0.0       0.0       0.0       0.0
    p_tochl_relt   =  0.0       0.0       0.0       0.0
    p_iswLtyp      =  5         5         5         5
    p_addepth      =  50.0      50.0      50.0      50.0
    p_chELiPPY     =  100.0     100.0     100.0     100.0
    p_clELiPPY     =  8.0       10.0      6.0       12.0
    p_ruELiPPY     =  0.2       0.25      0.3       0.15
    p_rPIm         =  0.0       0.0       0.0       0.0
/



&Phyto_parameters_iron
/


! Microzooplankton Parameter Namelist !
!-------------------------------------------------------------------------!
&MicroZoo_parameters
!                        Z5       Z6
    p_q10             =  2.0      2.0
    p_srs             =  $3     0.02
    p_sum             =  $4      4.0
    p_sdo             =  $5     0.25
    p_sd              =  $6      0.05
    p_pu              =  $7      0.5
    p_pu_ea           =  $8     0.3
    p_chro            =  $9      0.5
EOF
shift 9
/bin/cat << EOF >>Pelagic_Ecology.nml
    p_chuc            =  $1    200.0
    p_minfood         =  $2     20.0
    p_qpcMIZ          =  $3  1.85d-3
    p_qncMIZ          =  $4  1.67d-2
    p_paPBA           =  0.0      0.0
!                        P1       P2       P3   P4
!   Z5
    p_paPPY(1,:)      =  0.0      $5      0.0  0.0
!   Z6
    p_paPPY(2,:)      =  0.0      0.0      0.0  0.0
!                        Z5       Z6
!   Z5
    p_paMIZ(1,:)      =  0.0      0.0
!   Z6
    p_paMIZ(2,:)      =  0.0      0.0
/

! Mesozooplankton Parameter Namelist !
!-------------------------------------------------------------------------!
&MesoZoo_parameters
!                       Z3       Z4
    p_q10            =  2.0      2.0
    p_srs            =  0.01     0.02
    p_sum            =  2.0      2.0
    p_vum            =  0.025    0.025
    p_puI            =  0.6      0.6
    p_peI            =  0.3      0.35
    p_sdo            =  0.01     0.01
    p_sd             =  0.02     0.02
    p_sds            =  2.0      2.0
    p_qpcMEZ         =  1.67d-3  1.67d-3
    p_qncMEZ         =  0.015    0.015
    p_clO2o          =  30.0     30.0
!                       P1       P2       P3   P4
!   Z3
    p_paPPY(1,:)     =  0.0      0.0      0.0  0.0
!   Z4
    p_paPPY(2,:)     =  0.0      0.0      0.0  0.0
!                       Z5       Z6
!   Z3
    p_paMIZ(1,:)     =  0.0      0.0
!   Z4
    p_paMIZ(2,:)     =  0.0      0.0
!                       Z3       Z4
!   Z3
    p_paMEZ(1,:)     =  0.0      0.0
!   Z4
    p_paMEZ(2,:)     =  0.0      0.0
/
EOF
