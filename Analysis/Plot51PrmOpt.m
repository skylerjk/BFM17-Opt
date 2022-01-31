
close all, clear all, clc

% Set Text Interpreter
set(0, 'DefaultTextInterpreter', 'latex')

% Font Controls
fname = 'Times';
fsize = 9;

% Set color scheme for plots
FigClr = 'w'; 
AxsClr = 'k'; 
TxtClr = 'k';
lbox = 'off';

% % Directory Information % %
FileLoc = '../MS-Runs/BATS-51Prm-6objs-NrmRfSTD/PEOutput.dat';


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

Parameter_Labels = Parameter_List(:,2);

% % - Parameter reference values
prmval = [0.5, 0.5, 0.5, 0.2, 0.44, 0.664, 0.2, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5421, 0.5, 0.6667, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.5, 0.431, 0.258, 1.0, 0.5, ...
    1.0, 0.125, 0.125, 0.125, 0, 0, 0, 0.1, 0.12, 0.12, 0.12, 0.1];

% Optimization output data formatting parameters
delimiter = ' ';
hdr_lines = 1;

temp = importdata(FileLoc,delimiter,hdr_lines);
data = temp.data;

[num_evl, num] = size(data);
num_prm = num - 1; 
% 
prm_val = data(:,1:num_prm);
obj_val = data(:,num);

% Color Gradient for the progression of Optimization
clrgrd=[1:num_evl]/num_evl;

%%%%%%%%%%%%%%%%
% % Figure 1 % %
%%%%%%%%%%%%%%%%
% Plot of objective function evaluations through the optimization
f1 = figure(1);  f1.Color = FigClr; f1.InvertHardcopy = 'off';
sc = scatter([1:length(obj_val)],obj_val,[45],clrgrd,'filled');
sc.MarkerEdgeColor = [0.5 0.5 0.5];

yl = ylabel({'Objective Function';'Total Normalized RMSD'});
xl = xlabel('Optimization Evaluation');

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

colormap bone

%%%%%%%%%%%%%%%%
% % Figure 2 % %
%%%%%%%%%%%%%%%%
PrmAxisLabels = Parameter_Labels;
for i = 2:2:51
    PrmAxisLabels{i} = ['- - - ' Parameter_Labels{i}];
end

% Plot of difference in normalized parameter values through the optimization
f2 = figure(2); f2.Color = FigClr; f2.InvertHardcopy = 'off'; hold on

sc = scatter([1:51],prm_val(1,:),[90]); 
sc.MarkerFaceColor = 'r'; sc.MarkerEdgeColor = 'none';

for i=1:num_prm
    % Diff_final = prm_val(:,i) - prmval(i) ;
    sc = scatter(i*ones(1,num_evl),prm_val(:,i),[45],clrgrd,'filled');
    sc.MarkerEdgeColor = [0.5 0.5 0.5];;

end
yl = ylabel({'Normalized Parameter Value';'$\hat{p}_{i}$'}); 
% xl = xlabel('Parameter Index'); 

ylim([0.0 1.0]), xlim([0 num_prm+0.5])

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times'; ax.TickLabelInterpreter = 'latex';

set(gca,'xtick',[1:num_prm],'Xticklabel',PrmAxisLabels,'xticklabelrotation',270);

colormap bone
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='eastoutside';

%%%%%%%%%%%%%%%%
% % Figure 3 % %
%%%%%%%%%%%%%%%%
% Reordering the final result plot with respect to most sensitive
% parameters
Temp = load('ParameterIndexOrder.mat'); 
Index = Temp.Prm_Ind_Srt2;

for i = 1:length(Index)
    Parameter_Labels_Ord{i} = Parameter_Labels{Index(i)};
	
    prmval_ord(i) = prmval(Index(i));

    prm_val_ord(:,i) = prm_val(:,Index(i));
end

PrmAxisLabels_Ord = Parameter_Labels_Ord;
for i = 2:2:51
    PrmAxisLabels_Ord{i} = ['- - - ' Parameter_Labels_Ord{i}];
end

% Plot of difference in normalized parameter values through the optimization
% with parameter order determined by ranking from sensitivity analysis 
f3 = figure(3); f3.Color = FigClr; f3.InvertHardcopy = 'off'; hold on

sc = scatter([1:51],prm_val_ord(1,:),[90]); 
sc.MarkerFaceColor = 'r'; sc.MarkerEdgeColor = 'none';

for i=1:num_prm
    % Diff_final = prm_val_ord(:,i) - prmval_ord(i) ;
    sc = scatter(i*ones(1,num_evl),prm_val_ord(:,i),[45],clrgrd,'filled');
    sc.MarkerEdgeColor = [0.5 0.5 0.5];

end
yl = ylabel({'Normalized Parameter Value';'$\hat{p}_{i}$'});  

ln = line([29.5 29.5],[0.0 1.0]); ln.LineStyle = '--';

ylim([0.0 1.0]), xlim([0 num_prm+0.5])

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = fname; ax.TickLabelInterpreter = 'latex';

set(gca,'xtick',[1:num_prm],'Xticklabel',PrmAxisLabels_Ord,'xticklabelrotation',270);

colormap bone
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='eastoutside';