#ifdef BFM_NOPOINTERS


#define NOPOINTERS 1

#define O2o(A) D3STATE(ppO2o,A)
#define N1p(A) D3STATE(ppN1p,A)
#define N3n(A) D3STATE(ppN3n,A)
#define N4n(A) D3STATE(ppN4n,A)
#define O4n(A) D3STATE(ppO4n,A)
#define N5s(A) D3STATE(ppN5s,A)
#define N6r(A) D3STATE(ppN6r,A)
#define B1c(A) D3STATE(ppB1c,A)
#define B1n(A) D3STATE(ppB1n,A)
#define B1p(A) D3STATE(ppB1p,A)
#define P1c(A) D3STATE(ppP1c,A)
#define P1n(A) D3STATE(ppP1n,A)
#define P1p(A) D3STATE(ppP1p,A)
#define P1l(A) D3STATE(ppP1l,A)
#define P1s(A) D3STATE(ppP1s,A)
#define P2c(A) D3STATE(ppP2c,A)
#define P2n(A) D3STATE(ppP2n,A)
#define P2p(A) D3STATE(ppP2p,A)
#define P2l(A) D3STATE(ppP2l,A)
#define P3c(A) D3STATE(ppP3c,A)
#define P3n(A) D3STATE(ppP3n,A)
#define P3p(A) D3STATE(ppP3p,A)
#define P3l(A) D3STATE(ppP3l,A)
#define P4c(A) D3STATE(ppP4c,A)
#define P4n(A) D3STATE(ppP4n,A)
#define P4p(A) D3STATE(ppP4p,A)
#define P4l(A) D3STATE(ppP4l,A)
#define Z3c(A) D3STATE(ppZ3c,A)
#define Z3n(A) D3STATE(ppZ3n,A)
#define Z3p(A) D3STATE(ppZ3p,A)
#define Z4c(A) D3STATE(ppZ4c,A)
#define Z4n(A) D3STATE(ppZ4n,A)
#define Z4p(A) D3STATE(ppZ4p,A)
#define Z5c(A) D3STATE(ppZ5c,A)
#define Z5n(A) D3STATE(ppZ5n,A)
#define Z5p(A) D3STATE(ppZ5p,A)
#define Z6c(A) D3STATE(ppZ6c,A)
#define Z6n(A) D3STATE(ppZ6n,A)
#define Z6p(A) D3STATE(ppZ6p,A)
#define R1c(A) D3STATE(ppR1c,A)
#define R1n(A) D3STATE(ppR1n,A)
#define R1p(A) D3STATE(ppR1p,A)
#define R2c(A) D3STATE(ppR2c,A)
#define R3c(A) D3STATE(ppR3c,A)
#define R6c(A) D3STATE(ppR6c,A)
#define R6n(A) D3STATE(ppR6n,A)
#define R6p(A) D3STATE(ppR6p,A)
#define R6s(A) D3STATE(ppR6s,A)
#define O3c(A) D3STATE(ppO3c,A)
#define O3h(A) D3STATE(ppO3h,A)

#define PelBacteria(A,B) D3STATE(ppPelBacteria(A,B),:)
#define PhytoPlankton(A,B) D3STATE(ppPhytoPlankton(A,B),:)
#define MesoZooPlankton(A,B) D3STATE(ppMesoZooPlankton(A,B),:)
#define MicroZooPlankton(A,B) D3STATE(ppMicroZooPlankton(A,B),:)
#define PelDetritus(A,B) D3STATE(ppPelDetritus(A,B),:)
#define Inorganic(A,B) D3STATE(ppInorganic(A,B),:)

#define ETW(A) D3DIAGNOS(ppETW,A)
#define ESW(A) D3DIAGNOS(ppESW,A)
#define ERHO(A) D3DIAGNOS(ppERHO,A)
#define EIR(A) D3DIAGNOS(ppEIR,A)
#define ESS(A) D3DIAGNOS(ppESS,A)
#define EPR(A) D3DIAGNOS(ppEPR,A)
#define Depth(A) D3DIAGNOS(ppDepth,A)
#define Volume(A) D3DIAGNOS(ppVolume,A)
#define DIC(A) D3DIAGNOS(ppDIC,A)
#define Area(A) D3DIAGNOS(ppArea,A)
#define CO2(A) D3DIAGNOS(ppCO2,A)
#define pCO2(A) D3DIAGNOS(pppCO2,A)
#define HCO3(A) D3DIAGNOS(ppHCO3,A)
#define CO3(A) D3DIAGNOS(ppCO3,A)
#define ALK(A) D3DIAGNOS(ppALK,A)
#define pH(A) D3DIAGNOS(pppH,A)
#define OCalc(A) D3DIAGNOS(ppOCalc,A)
#define OArag(A) D3DIAGNOS(ppOArag,A)
#define totpelc(A) D3DIAGNOS(pptotpelc,A)
#define totpeln(A) D3DIAGNOS(pptotpeln,A)
#define totpelp(A) D3DIAGNOS(pptotpelp,A)
#define totpels(A) D3DIAGNOS(pptotpels,A)
#define cxoO2(A) D3DIAGNOS(ppcxoO2,A)
#define eO2mO2(A) D3DIAGNOS(ppeO2mO2,A)
#define Chla(A) D3DIAGNOS(ppChla,A)
#define flPTN6r(A) D3DIAGNOS(ppflPTN6r,A)
#define flN3O4n(A) D3DIAGNOS(ppflN3O4n,A)
#define flN4N3n(A) D3DIAGNOS(ppflN4N3n,A)
#define sediR2(A) D3DIAGNOS(ppsediR2,A)
#define sediR6(A) D3DIAGNOS(ppsediR6,A)
#define xEPS(A) D3DIAGNOS(ppxEPS,A)
#define ABIO_eps(A) D3DIAGNOS(ppABIO_eps,A)

#define EPCO2air(A) D2DIAGNOS(ppEPCO2air,A)
#define CO2airflux(A) D2DIAGNOS(ppCO2airflux,A)
#define Area2d(A) D2DIAGNOS(ppArea2d,A)
#define ThereIsLight(A) D2DIAGNOS(ppThereIsLight,A)
#define SUNQ(A) D2DIAGNOS(ppSUNQ,A)
#define totsysc(A) D2DIAGNOS(pptotsysc,A)
#define totsysn(A) D2DIAGNOS(pptotsysn,A)
#define EWIND(A) D2DIAGNOS(ppEWIND,A)
#define totsysp(A) D2DIAGNOS(pptotsysp,A)
#define totsyss(A) D2DIAGNOS(pptotsyss,A)
#define EICE(A) D2DIAGNOS(ppEICE,A)

#define PELSURFACE(A,B) D2DIAGNOS(11+A,B)
#define jsurO2o(B) D2DIAGNOS(11+ppO2o,B)
#define jsurN1p(B) D2DIAGNOS(11+ppN1p,B)
#define jsurN3n(B) D2DIAGNOS(11+ppN3n,B)
#define jsurN4n(B) D2DIAGNOS(11+ppN4n,B)
#define jsurO4n(B) D2DIAGNOS(11+ppO4n,B)
#define jsurN5s(B) D2DIAGNOS(11+ppN5s,B)
#define jsurN6r(B) D2DIAGNOS(11+ppN6r,B)
#define jsurB1c(B) D2DIAGNOS(11+ppB1c,B)
#define jsurB1n(B) D2DIAGNOS(11+ppB1n,B)
#define jsurB1p(B) D2DIAGNOS(11+ppB1p,B)
#define jsurP1c(B) D2DIAGNOS(11+ppP1c,B)
#define jsurP1n(B) D2DIAGNOS(11+ppP1n,B)
#define jsurP1p(B) D2DIAGNOS(11+ppP1p,B)
#define jsurP1l(B) D2DIAGNOS(11+ppP1l,B)
#define jsurP1s(B) D2DIAGNOS(11+ppP1s,B)
#define jsurP2c(B) D2DIAGNOS(11+ppP2c,B)
#define jsurP2n(B) D2DIAGNOS(11+ppP2n,B)
#define jsurP2p(B) D2DIAGNOS(11+ppP2p,B)
#define jsurP2l(B) D2DIAGNOS(11+ppP2l,B)
#define jsurP3c(B) D2DIAGNOS(11+ppP3c,B)
#define jsurP3n(B) D2DIAGNOS(11+ppP3n,B)
#define jsurP3p(B) D2DIAGNOS(11+ppP3p,B)
#define jsurP3l(B) D2DIAGNOS(11+ppP3l,B)
#define jsurP4c(B) D2DIAGNOS(11+ppP4c,B)
#define jsurP4n(B) D2DIAGNOS(11+ppP4n,B)
#define jsurP4p(B) D2DIAGNOS(11+ppP4p,B)
#define jsurP4l(B) D2DIAGNOS(11+ppP4l,B)
#define jsurZ3c(B) D2DIAGNOS(11+ppZ3c,B)
#define jsurZ3n(B) D2DIAGNOS(11+ppZ3n,B)
#define jsurZ3p(B) D2DIAGNOS(11+ppZ3p,B)
#define jsurZ4c(B) D2DIAGNOS(11+ppZ4c,B)
#define jsurZ4n(B) D2DIAGNOS(11+ppZ4n,B)
#define jsurZ4p(B) D2DIAGNOS(11+ppZ4p,B)
#define jsurZ5c(B) D2DIAGNOS(11+ppZ5c,B)
#define jsurZ5n(B) D2DIAGNOS(11+ppZ5n,B)
#define jsurZ5p(B) D2DIAGNOS(11+ppZ5p,B)
#define jsurZ6c(B) D2DIAGNOS(11+ppZ6c,B)
#define jsurZ6n(B) D2DIAGNOS(11+ppZ6n,B)
#define jsurZ6p(B) D2DIAGNOS(11+ppZ6p,B)
#define jsurR1c(B) D2DIAGNOS(11+ppR1c,B)
#define jsurR1n(B) D2DIAGNOS(11+ppR1n,B)
#define jsurR1p(B) D2DIAGNOS(11+ppR1p,B)
#define jsurR2c(B) D2DIAGNOS(11+ppR2c,B)
#define jsurR3c(B) D2DIAGNOS(11+ppR3c,B)
#define jsurR6c(B) D2DIAGNOS(11+ppR6c,B)
#define jsurR6n(B) D2DIAGNOS(11+ppR6n,B)
#define jsurR6p(B) D2DIAGNOS(11+ppR6p,B)
#define jsurR6s(B) D2DIAGNOS(11+ppR6s,B)
#define jsurO3c(B) D2DIAGNOS(11+ppO3c,B)
#define jsurO3h(B) D2DIAGNOS(11+ppO3h,B)

#define PELBOTTOM(A,B) D2DIAGNOS(61+A,B)
#define jbotO2o(B) D2DIAGNOS(61+ppO2o,B)
#define jbotN1p(B) D2DIAGNOS(61+ppN1p,B)
#define jbotN3n(B) D2DIAGNOS(61+ppN3n,B)
#define jbotN4n(B) D2DIAGNOS(61+ppN4n,B)
#define jbotO4n(B) D2DIAGNOS(61+ppO4n,B)
#define jbotN5s(B) D2DIAGNOS(61+ppN5s,B)
#define jbotN6r(B) D2DIAGNOS(61+ppN6r,B)
#define jbotB1c(B) D2DIAGNOS(61+ppB1c,B)
#define jbotB1n(B) D2DIAGNOS(61+ppB1n,B)
#define jbotB1p(B) D2DIAGNOS(61+ppB1p,B)
#define jbotP1c(B) D2DIAGNOS(61+ppP1c,B)
#define jbotP1n(B) D2DIAGNOS(61+ppP1n,B)
#define jbotP1p(B) D2DIAGNOS(61+ppP1p,B)
#define jbotP1l(B) D2DIAGNOS(61+ppP1l,B)
#define jbotP1s(B) D2DIAGNOS(61+ppP1s,B)
#define jbotP2c(B) D2DIAGNOS(61+ppP2c,B)
#define jbotP2n(B) D2DIAGNOS(61+ppP2n,B)
#define jbotP2p(B) D2DIAGNOS(61+ppP2p,B)
#define jbotP2l(B) D2DIAGNOS(61+ppP2l,B)
#define jbotP3c(B) D2DIAGNOS(61+ppP3c,B)
#define jbotP3n(B) D2DIAGNOS(61+ppP3n,B)
#define jbotP3p(B) D2DIAGNOS(61+ppP3p,B)
#define jbotP3l(B) D2DIAGNOS(61+ppP3l,B)
#define jbotP4c(B) D2DIAGNOS(61+ppP4c,B)
#define jbotP4n(B) D2DIAGNOS(61+ppP4n,B)
#define jbotP4p(B) D2DIAGNOS(61+ppP4p,B)
#define jbotP4l(B) D2DIAGNOS(61+ppP4l,B)
#define jbotZ3c(B) D2DIAGNOS(61+ppZ3c,B)
#define jbotZ3n(B) D2DIAGNOS(61+ppZ3n,B)
#define jbotZ3p(B) D2DIAGNOS(61+ppZ3p,B)
#define jbotZ4c(B) D2DIAGNOS(61+ppZ4c,B)
#define jbotZ4n(B) D2DIAGNOS(61+ppZ4n,B)
#define jbotZ4p(B) D2DIAGNOS(61+ppZ4p,B)
#define jbotZ5c(B) D2DIAGNOS(61+ppZ5c,B)
#define jbotZ5n(B) D2DIAGNOS(61+ppZ5n,B)
#define jbotZ5p(B) D2DIAGNOS(61+ppZ5p,B)
#define jbotZ6c(B) D2DIAGNOS(61+ppZ6c,B)
#define jbotZ6n(B) D2DIAGNOS(61+ppZ6n,B)
#define jbotZ6p(B) D2DIAGNOS(61+ppZ6p,B)
#define jbotR1c(B) D2DIAGNOS(61+ppR1c,B)
#define jbotR1n(B) D2DIAGNOS(61+ppR1n,B)
#define jbotR1p(B) D2DIAGNOS(61+ppR1p,B)
#define jbotR2c(B) D2DIAGNOS(61+ppR2c,B)
#define jbotR3c(B) D2DIAGNOS(61+ppR3c,B)
#define jbotR6c(B) D2DIAGNOS(61+ppR6c,B)
#define jbotR6n(B) D2DIAGNOS(61+ppR6n,B)
#define jbotR6p(B) D2DIAGNOS(61+ppR6p,B)
#define jbotR6s(B) D2DIAGNOS(61+ppR6s,B)
#define jbotO3c(B) D2DIAGNOS(61+ppO3c,B)
#define jbotO3h(B) D2DIAGNOS(61+ppO3h,B)

#define PELRIVER(A,B) D2DIAGNOS(111+A,B)
#define jrivO2o(B) D2DIAGNOS(111+ppO2o,B)
#define jrivN1p(B) D2DIAGNOS(111+ppN1p,B)
#define jrivN3n(B) D2DIAGNOS(111+ppN3n,B)
#define jrivN4n(B) D2DIAGNOS(111+ppN4n,B)
#define jrivO4n(B) D2DIAGNOS(111+ppO4n,B)
#define jrivN5s(B) D2DIAGNOS(111+ppN5s,B)
#define jrivN6r(B) D2DIAGNOS(111+ppN6r,B)
#define jrivB1c(B) D2DIAGNOS(111+ppB1c,B)
#define jrivB1n(B) D2DIAGNOS(111+ppB1n,B)
#define jrivB1p(B) D2DIAGNOS(111+ppB1p,B)
#define jrivP1c(B) D2DIAGNOS(111+ppP1c,B)
#define jrivP1n(B) D2DIAGNOS(111+ppP1n,B)
#define jrivP1p(B) D2DIAGNOS(111+ppP1p,B)
#define jrivP1l(B) D2DIAGNOS(111+ppP1l,B)
#define jrivP1s(B) D2DIAGNOS(111+ppP1s,B)
#define jrivP2c(B) D2DIAGNOS(111+ppP2c,B)
#define jrivP2n(B) D2DIAGNOS(111+ppP2n,B)
#define jrivP2p(B) D2DIAGNOS(111+ppP2p,B)
#define jrivP2l(B) D2DIAGNOS(111+ppP2l,B)
#define jrivP3c(B) D2DIAGNOS(111+ppP3c,B)
#define jrivP3n(B) D2DIAGNOS(111+ppP3n,B)
#define jrivP3p(B) D2DIAGNOS(111+ppP3p,B)
#define jrivP3l(B) D2DIAGNOS(111+ppP3l,B)
#define jrivP4c(B) D2DIAGNOS(111+ppP4c,B)
#define jrivP4n(B) D2DIAGNOS(111+ppP4n,B)
#define jrivP4p(B) D2DIAGNOS(111+ppP4p,B)
#define jrivP4l(B) D2DIAGNOS(111+ppP4l,B)
#define jrivZ3c(B) D2DIAGNOS(111+ppZ3c,B)
#define jrivZ3n(B) D2DIAGNOS(111+ppZ3n,B)
#define jrivZ3p(B) D2DIAGNOS(111+ppZ3p,B)
#define jrivZ4c(B) D2DIAGNOS(111+ppZ4c,B)
#define jrivZ4n(B) D2DIAGNOS(111+ppZ4n,B)
#define jrivZ4p(B) D2DIAGNOS(111+ppZ4p,B)
#define jrivZ5c(B) D2DIAGNOS(111+ppZ5c,B)
#define jrivZ5n(B) D2DIAGNOS(111+ppZ5n,B)
#define jrivZ5p(B) D2DIAGNOS(111+ppZ5p,B)
#define jrivZ6c(B) D2DIAGNOS(111+ppZ6c,B)
#define jrivZ6n(B) D2DIAGNOS(111+ppZ6n,B)
#define jrivZ6p(B) D2DIAGNOS(111+ppZ6p,B)
#define jrivR1c(B) D2DIAGNOS(111+ppR1c,B)
#define jrivR1n(B) D2DIAGNOS(111+ppR1n,B)
#define jrivR1p(B) D2DIAGNOS(111+ppR1p,B)
#define jrivR2c(B) D2DIAGNOS(111+ppR2c,B)
#define jrivR3c(B) D2DIAGNOS(111+ppR3c,B)
#define jrivR6c(B) D2DIAGNOS(111+ppR6c,B)
#define jrivR6n(B) D2DIAGNOS(111+ppR6n,B)
#define jrivR6p(B) D2DIAGNOS(111+ppR6p,B)
#define jrivR6s(B) D2DIAGNOS(111+ppR6s,B)
#define jrivO3c(B) D2DIAGNOS(111+ppO3c,B)
#define jrivO3h(B) D2DIAGNOS(111+ppO3h,B)

#define sunPPY(A,B) D3DIAGNOS(ppsunPPY(A),B)
#define qpcPPY(A,B) D3DIAGNOS(ppqpcPPY(A),B)
#define qncPPY(A,B) D3DIAGNOS(ppqncPPY(A),B)
#define qscPPY(A,B) D3DIAGNOS(ppqscPPY(A),B)
#define qlcPPY(A,B) D3DIAGNOS(ppqlcPPY(A),B)
#define qpcMEZ(A,B) D3DIAGNOS(ppqpcMEZ(A),B)
#define qncMEZ(A,B) D3DIAGNOS(ppqncMEZ(A),B)
#define qpcMIZ(A,B) D3DIAGNOS(ppqpcMIZ(A),B)
#define qncMIZ(A,B) D3DIAGNOS(ppqncMIZ(A),B)
#define qpcOMT(A,B) D3DIAGNOS(ppqpcOMT(A),B)
#define qncOMT(A,B) D3DIAGNOS(ppqncOMT(A),B)
#define qscOMT(A,B) D3DIAGNOS(ppqscOMT(A),B)
#define qpcPBA(A,B) D3DIAGNOS(ppqpcPBA(A),B)
#define qncPBA(A,B) D3DIAGNOS(ppqncPBA(A),B)
#define sediPPY(A,B) D3DIAGNOS(ppsediPPY(A),B)
#define sediMIZ(A,B) D3DIAGNOS(ppsediMIZ(A),B)
#define sediMEZ(A,B) D3DIAGNOS(ppsediMEZ(A),B)
#define eiPPY(A,B) D3DIAGNOS(ppeiPPY(A),B)
#define ELiPPY(A,B) D3DIAGNOS(ppELiPPY(A),B)


#ifdef INCLUDE_SEAICE






#endif

#ifdef INCLUDE_BEN






#endif


#endif



#if defined INCLUDE_BENCO2 && !defined INCLUDE_BEN
#undef INCLUDE_BENCO2
#endif
#if defined INCLUDE_BENPROFILES && !defined INCLUDE_BEN
#undef INCLUDE_BENPROFILES
#endif
