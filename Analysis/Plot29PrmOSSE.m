%% Plotting the 10% parameter optimization cases

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
FileLoc = '../QN-Runs/OSSE-29Prm-17StVr-0.1perc-NrmRfSTD-CC1e-6/PEOutput.dat';

% %% Parameter Set All
% % - Parameters Being Tested
Parameter_List = ...
    {'p_PAR', '$\varepsilon_{\mathrm{PAR}}$'; ...                   % 0.5
      'p_eps0', '$\lambda _w$'; ...                                 % 0.5
      'p_pe_R1c', '$\varepsilon_{Z}^{(\mathrm{C})}$'; ...           % 0.2
      'p_pe_R1n', '$\varepsilon_{Z}^{(\mathrm{N})}$'; ...           % 0.44
      'p_pe_R1p', '$\varepsilon_{Z}^{(\mathrm{P})}$'; ...           % 0.664
      'p_sum', '$r_P^{(0)}$'; ...                                   % 0.2
      'p_srs', '$b_P$'; ...                                         % 0.5
      'p_sdmo', '$d_P^{(0)}$'; ...                                  % 0.5
      'p_thdo', '$h_P^{(\mathrm{N,P})}$'; ...                       % 0.5
      'p_pu_ea', '$\beta_P$'; ...                                   % 0.5
      'p_pu_ra', '$\gamma_P$'; ...                                  % 0.5
      'p_qncPPY','$\phi_{\mathrm{N}}^{(\mathrm{op})}$'; ...         % 0.5
      'p_xqn', '$\phi_{\mathrm{N}}^{(\mathrm{mx})}$'; ...           % 0.5
      'p_qup', '$a_P^{(\mathrm{P})}$'; ...                          % 0.5
      'p_qplc', '$\phi_{\mathrm{P}}^{(\mathrm{mn})}$'; ...          % 0.5
      'p_qpcPPY', '$\phi_{\mathrm{P}}^{(\mathrm{op})}$'; ...        % 0.542
      'p_xqp', '$\phi_{\mathrm{P}}^{(\mathrm{mx})}$'; ...           % 0.5
      'p_alpha_chl', '$\alpha_{\mathrm{chl}}^{(0)}$'; ...           % 0.5
      'p_qlcPPY', '$\theta_{\mathrm{chl}}^{(0)}$'; ...              % 0.5
      'z_srs', '$b_Z$'; ...                                         % 0.25
      'z_sd', '$d_Z$'; ...                                          % 0.5
      'p_sN4N3', '$\lambda_{N^{(3)}}^{(\mathrm{nit})}$'; ...        % 0.5
      'p_sR6O3', '$\xi_{\mathrm{CO}_2}$'; ...                       % 0.125
      'p_sR6N1', '$\xi_{N^{(1)}}$'; ...                             % 0.125
      'p_sR6N4', '$\xi_{N^{(2)}}$'; ...                             % 0.125
      'p_sR1O3', '$\zeta_{\mathrm{CO}_2}$'; ...                     % 0.0
      'p_sR1N1', '$\zeta_{N^{(1)}}$'; ...                           % 0.0
      'p_sR1N4', '$\zeta_{N^{(2)}}$'; ...                           % 0.0
      'p_rR6m', '$v^{(\mathrm{st})}$'};                             % 0.1

Parameter_Labels = Parameter_List(:,2);

% - Parameter reference values
prmval = [0.5, 0.5, 0.2, 0.44, 0.664, 0.2, 0.5, 0.5, 0.5, 0.5, 0.5, ...
    0.5, 0.5, 0.5, 0.5, 0.5421, 0.5, 0.5, 0.5, 0.25, 0.5, 0.5, 0.125, 0.125, ...
    0.125, 0, 0, 0, 0.1];

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
for i = 2:2:num_prm
    PrmAxisLabels{i} = ['- - - ' Parameter_Labels{i}];
end

% Plot of difference in normalized parameter values through the optimization
f2 = figure(2); f2.Color = FigClr; f2.InvertHardcopy = 'off'; hold on
sc = scatter([1:29],prm_val(1,:)-prmval,[90]); 
sc.MarkerFaceColor = 'r'; sc.MarkerEdgeColor = 'none';

for i=1:num_prm
    Diff_final = prm_val(:,i) - prmval(i) ;
    sc = scatter(i*ones(1,num_evl),Diff_final,[45],clrgrd,'filled');
    sc.MarkerEdgeColor = [0.5 0.5 0.5];

end
% sc = scatter([1:29],prm_val(1,:)-prmval); sc.MarkerFaceColor = 'r'; 

yl = ylabel({'Difference in Normalized Parameter Value';'$p_{i} - p_{o}$'}); 
% xl = xlabel('Parameter Index'); 

yline(0)
xlim([0 num_prm+0.5])% , ylim([-0.02 0.02])

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times'; ax.TickLabelInterpreter = 'latex';

set(gca,'xtick',[1:num_prm],'Xticklabel',PrmAxisLabels,'xticklabelrotation',270);

colormap bone
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='eastoutside';