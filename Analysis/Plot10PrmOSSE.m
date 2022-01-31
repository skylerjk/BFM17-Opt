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
FileLoc = '../QN-Runs/OSSE-10Prm-17StVr-dt400-PrmSet13-10perc-NrmRfSTD-GS1e-5-CC1e-04/PEOutput.dat';


% %% Parameter Set All
% % - Parameters Being Tested
Parameter_List = ...
    {'p_eps0', '$\lambda _w$'; ...
      'p_qup', '$a_P^{(\mathrm{P})}$'; ...
      'p_qplc', '$\phi_{\mathrm{P}}^{(\mathrm{mn})}$'; ...
      'p_qpcPPY', '$\phi_{\mathrm{P}}^{(\mathrm{op})}$'; ...
      'p_qlcPPY', '$\theta_{\mathrm{chl}}^{(0)}$'; ...
      'z_srs', '$b_Z$'; ...
      'z_sd', '$d_Z$'; ...
      'p_sR6N1', '$\xi_{N^{(1)}}$'; ...
      'p_sR1N1', '$\zeta_{N^{(1)}}$'; ...
      'p_sR1N4', '$\zeta_{N^{(2)}}$'};

Parameter_Labels = Parameter_List(:,2);

% - Parameter reference values
prmval = [0.5,0.5,0.5,0.542,0.5,0.25,0.5,0.125,0.0,0.0];

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
for i=1:num_prm
    Diff_final = prm_val(:,i) - prmval(i) ;
    sc = scatter(i*ones(1,num_evl),Diff_final,[45],clrgrd,'filled');
    sc.MarkerEdgeColor = [0.5 0.5 0.5];;

end
yl = ylabel({'Difference in Normalized Parameter Value';'$p_{i} - p_{o}$'}); 

yline(0)
xlim([0 num_prm+0.5])

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times'; ax.TickLabelInterpreter = 'latex';

set(gca,'xtick',[1:num_prm],'Xticklabel',PrmAxisLabels,'xticklabelrotation',270);

colormap bone
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='eastoutside';