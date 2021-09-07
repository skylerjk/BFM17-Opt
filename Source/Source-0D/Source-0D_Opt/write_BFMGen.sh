/bin/cat << EOF >BFM_General.nml
! bfm_nml !
!-------------------------------------------------------------------------!
&bfm_nml
    bio_calc      =  .TRUE.
    bfm_init      =  0
    bfm_rstctl    =  .FALSE.
    bio_setup     =  1
    out_fname     =  'BFM_standalone_pelagic'
    out_dir       =  '.'
    out_title     =  'BFM_STANDALONE_PELAGIC'
    in_rst_fname  =  'in_bfm_restart'
    out_delta     =  24
    parallel_log  =  .FALSE.
/

! Param_parameters !
!-------------------------------------------------------------------------!
&Param_parameters
    CalcPelagicFlag              =  .TRUE.
    CalcBenthicFlag              =  0
    CalcConservationFlag         =  .FALSE.
    CalcTransportFlag            =  .FALSE.
    CalcPhytoPlankton(1)         =  .FALSE.
    CalcPhytoPlankton(2)         =  .TRUE.
    CalcPhytoPlankton(3)         =  .FALSE.
    CalcPhytoPlankton(4)         =  .FALSE.
    CalcPelBacteria(1)           =  .FALSE.
    CalcMicroZooPlankton(1)      =  .TRUE.
    CalcMicroZooPlankton(2)      =  .FALSE.
    CalcMesoZooPlankton(1)       =  .FALSE.
    CalcMesoZooPlankton(2)       =  .FALSE.
    CalcPelChemistry             =  .TRUE.
    AssignPelBenFluxesInBFMFlag  =  .FALSE.
    AssignAirPelFluxesInBFMFlag  =  .TRUE.
    ChlDynamicsFlag              =  2
    check_fixed_quota            =  0
    p_small                      =  1.0e-20
    slp0                         =  1013.25E0
    p_pe_R1c                     =  $1
    p_pe_R1n                     =  $2
    p_pe_R1p                     =  $3
    p_qro                        =  0.5
    p_qon_dentri                 =  1.25
    p_qon_nitri                  =  2.0
/



! bfm_init_nml !
!-------------------------------------------------------------------------!
&bfm_init_nml
    O2o0       =  230.0
    N1p0       =  0.06
    N3n0       =  1.0
    N4n0       =  0.06
    N5s0       =  8.0
    N6r0       =  1.0
    O3c0       =  27060.00
    O3h0       =  2660.0
    O4n0       =  200.0
    P1c0       =  1.0
    P2c0       =  12.0
    P3c0       =  1.0
    P4c0       =  1.0
    Z3c0       =  1.0
    Z4c0       =  1.0
    Z5c0       =  12.0
    Z6c0       =  1.0
    B1c0       =  1.0
    R1c0       =  12.0
    R2c0       =  1.0
    R3c0       =  1.0
    R6c0       =  12.0
/



! bfm_save_nml !
!-------------------------------------------------------------------------!
&bfm_save_nml
    var_save   =  ''
    ave_save   =  'ETW' 'ESW' 'EWIND' 'EIR' 'O2o' 'N1p' 'N3n' 'N4n' 'P2c' 'P2n' 'P2p' 'P2l' 'Z5c' 'Z5n' 'Z5p' 'R1c' 'R6c'  'R1n'  'R6n'  'R1p' 'R6p' 'eiPPY(iiP2)' 'sunPPY(iiP2)' 'ruPPYc' 'resZOOc' 'ruPPYn' 'ruPPYp' 'exPPYc' 'ruZOOc' 'remZOOn' 'remZOOp'
/
EOF
