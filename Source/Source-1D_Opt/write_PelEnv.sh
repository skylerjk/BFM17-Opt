/bin/cat << EOF >Pelagic_Environment.nml
&PelChem_parameters
    p_q10N4N3        =  2.00
    p_sN4N3          =  $1
    p_clO2o          =  $2
    p_rOS            =  0.05
    p_sN3O4n         =  0.35
    p_clN6r          =  1.0
    p_rPAo           =  1.0
    p_q10R6N5        =  1.49
    p_sR6N5          =  0.02
/

&PelChem_parameters_iron
/

&PelChem_parameters_NO_BACT
    p_sR6O3                  =  $3
    p_sR6N1                  =  $4
    p_sR6N4                  =  $5
    p_sR1O3                  =  $6
    p_sR1N1                  =  $7
    p_sR1N4                  =  $8
    p_sR2O3                  =  0.25
    p_sR3O3                  =  0.25
/

&PelGlobal_parameters
    p_rR6m             =  $9
    p_rPIm             =  0.0  0.0  0.0  0.0
/

EOF
