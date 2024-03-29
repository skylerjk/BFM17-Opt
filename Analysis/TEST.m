% %% Parameter Set All
% % - Parameters Being Tested
Parameter_List = ...
    {'p_PAR', '$\varepsilon_{\mathrm{PAR}}$'; ...
      'p_eps0', '$\lambda _w$'; ...
      'p_epsR6', '$c_{R^(2)}$'; ...
      'p_pe_R1c', '$\varepsilon_{Z}^{(\mathrm{C})}$'; ...
      'p_pe_R1n', '$\varepsilon_{Z}^{(\mathrm{N})}$'; ...
      'p_pe_R1p', '$\varepsilon_{Z}^{(\mathrm{P})}$'; ...
      'p_sum', '$r_P^{(0)}$'; ...
      'p_srs', '$b_P$'; ...
      'p_sdmo', '$d_P^{(0)}$'; ...
      'p_thdo', '$h_P^{(\mathrm{N,P})}$'; ...
      'p_pu_ea', '$\beta_P$'; ...
      'p_pu_ra', '$\gamma_P$'; ...
      'p_qun', '$a_P^{(\mathrm{N})}$'; ...
      'p_lN4', '$h_P^{(\mathrm{N})}$'; ...
      'p_qnlc', '$\phi_{\mathrm{N}}^{(\mathrm{mn})}$';...
      'p_qncPPY','$\phi_{\mathrm{N}}^{(\mathrm{op})}$'; ...
      'p_xqn', '$\phi_{\mathrm{N}}^{(\mathrm{mx})}$'; ...
      'p_qup', '$a_P^{(\mathrm{P})}$'; ...
      'p_qplc', '$\phi_{\mathrm{P}}^{(\mathrm{mn})}$'; ...
      'p_qpcPPY', '$\phi_{\mathrm{P}}^{(\mathrm{op})}$'; ...
      'p_xqp', '$\phi_{\mathrm{P}}^{(\mathrm{mx})}$'; ...
      'p_esNI', '$l_P^{(\mathrm{sk})}$'; ...
      'p_res', '$w_P^{(\mathrm{sk})}$'; ...
      'p_alpha_chl', '$\alpha_{\mathrm{chl}}^{(0)}$'; ...
      'p_qlcPPY', '$\theta_{\mathrm{chl}}^{(0)}$'; ...
      'p_epsChla', '$c_P$'; ...
      'z_srs', '$b_Z$'; ...
      'z_sum', '$r_Z^{(0)}$'; ...
      'z_sdo', '$d_Z^{(0)}$'; ...
      'z_sd', '$d_Z$'; ...
      'z_pu', '$\eta_Z$'; ...
      'z_pu_ea', '$\beta_Z$'; ...
      'z_chro', '$h_Z^{(O)}$'; ...
      'z_chuc', '$h_Z^{(F)}$'; ...
      'z_minfood', '$\mu_Z$'; ...
      'z_qpcMIZ', '$\varphi_{\mathrm{P}}^{(\mathrm{op})}$'; ...
      'z_qncMIZ', '$\varphi_{\mathrm{N}}^{(\mathrm{op})}$'; ...
      'z_paPPY', '$\delta_Z$'; ...
      'p_sN4N3', '$\lambda_{N^{(3)}}^{(\mathrm{nit})}$'; ...
      'p_clO2o', '$h_N^{(O)}$'; ...
      'p_sR6O3', '$\xi_{\mathrm{CO}_2}$'; ...
      'p_sR6N1', '$\xi_{N^{(1)}}$'; ...
      'p_sR6N4', '$\xi_{N^{(2)}}$'; ...
      'p_sR1O3', '$\zeta_{\mathrm{CO}_2}$'; ...
      'p_sR1N1', '$\zeta_{N^{(1)}}$'; ...
      'p_sR1N4', '$\zeta_{N^{(2)}}$'; ...
      'p_rR6m', '$v^{(\mathrm{st})}$'; ...
      'NRT_o2o', '$\lambda_{O}$'; ...
      'NRT_n1p', '$\lambda_{N^{(1)}}$'; ...
      'NRT_n3n', '$\lambda_{N^{(2)}}$'; ...
      'NRT_n4n', '$\lambda_{N^{(3)}}$'};

Parameter_Labels = Parameter_List(:,2)

PrmAxisLabels = Parameter_Labels
for i = 2:2:51
    PrmAxisLabels{i} = ['- - - ' Parameter_Labels{i}];
end

PrmAxisLabels