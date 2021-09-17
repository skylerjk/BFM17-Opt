/bin/cat << EOF >Pelagic_Environment.nml
! PAR_parameters !
!-------------------------------------------------------------------------!
&PAR_parameters
    LightPeriodFlag    =  1
    LightLocationFlag  =  3
    ChlAttenFlag       =  1
    p_PAR              =  $1
    p_eps0             =  $2
    p_epsIR            =  2.857
    p_epsESS           =  0.04d-3
    p_epsR6            =  $3
/



! PelChem_parameters, PelChem_parameters_iron !
!-------------------------------------------------------------------------!
&PelChem_parameters
    p_q10N4N3        =  2.367
    p_sN4N3          =  $4
    p_clO2o          =  $5
    p_rOS            =  0.05
    p_sN3O4n         =  0.35
    p_clN6r          =  1.0
    p_rPAo           =  1.0
    p_q10R6N5        =  1.49
    p_sR6N5          =  0.02
/

EOF
shift 5
/bin/cat << EOF >>Pelagic_Environment.nml

&PelChem_parameters_BFM_16
    p_sR6O3                 =  $1
    p_sR1O3                 =  $2
    p_sR2O3                 =  0.25
    p_sR6N1                 =  $3
    p_sR1N1                 =  $4
    p_sR6N4                 =  $5
    p_sR1N4                 =  $6
/



&PelChem_parameters_iron
/



! PelGlobal_parameters !
!-------------------------------------------------------------------------!
&PelGlobal_parameters
    p_rR6m             =  $7
    KSINK_rPPY         =  150.0
    AggregateSink      =  .FALSE.
    depth_factor       =  2000.0
/
EOF
