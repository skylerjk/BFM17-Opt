% =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= %
% Script : Plot_1PrmOSSE.m                                                %
%                                                                         %
% Description :                                                           %
% This script produces plots of the results for an observing system       %
% simulation experiment with BFM17 + POM1D. The model parameter has been  %
% perturbed by some ammount. DAKOTA is then used to optimize the          %
% parameter value in an attempt to recover the original (nominal)         %
% parameter value. This script plots the results of this optimization.    %
% A plot of the objective function and the parameter progression is       %
% produced. 
%                                                                         %
% Developed :                                                             %
% Skyler Kern - October 5, 2021                                           %
%                                                                         %
% Institution :                                                           %
% This was created in support of research done in the Turbulence and      %
% Energy Systems Laboratory (TESLa) from the Paul M. Rady Department of   %
% Mechanical Engineering at the University of Colorado Boulder.           %           
%                                                                         %
% =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= %

close all, clear all, clc

% Set color scheme for plots
ClrCase = 'Paper';
switch ClrCase
    case 'Paper'
        FigClr = 'w'; AxsClr = 'k'; TxtClr = 'k';
        lbox = 'off';
    case 'Presentation'
        FigClr = 'k'; AxsClr = 'w'; TxtClr = 'w';
        lbox = 'off';
end

% % Directory Information % %
FileLoc = '../PE-Runs/OSSE-1D-01Prm-17StVr-FRCGwNorm-dt400-Prm_p_pe_R1c-10percpert/PEOutput.dat';

%% Parameter %%
% - Parameters Being Tested
prmtr = 'p\_pe\_R1c'
% - Parameter reference values
prmval = 0.2;

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
f1 = figure(1);  f1.Color = FigClr; f1.InvertHardcopy = 'off';
scatter([1:length(obj_val)],obj_val,[45],clrgrd,'filled')

ttl = title('Optimization of RMSD'); ttl.Color = TxtClr;
ylabel('Objective Function, RMSD'), xlabel('Objective Function Evaluation')
%ylim([1 51])
% 
ax = gca; % ax.YScale='log';
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

colormap cool


%%%%%%%%%%%%%%%%
% % Figure 2 % % 
%%%%%%%%%%%%%%%%
% f2 = figure(2); f2.Color = FigClr; f2.InvertHardcopy = 'off';
% Diff_final = prmval - prm_val(length(prm_val),:);
% scatter(1:num_prm,Diff_final)
% 
% ttl = title('OSSE of 51 Parameters'); ttl.Color = TxtClr;
% xlabel('Parameter Index'), ylabel('Diff, Nom Val - Opt Val')
% line([1 51],[0 0]), xlim([0 51])
% % 
% ax = gca;
% ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
% ax.Box = 'on'; ax.FontName = 'Times';

%%%%%%%%%%%%%%%%
% % Figure 2 % %
%%%%%%%%%%%%%%%%
f3 = figure(2); f3.Color = FigClr; f3.InvertHardcopy = 'off';
for i=1:num_prm
    Diff_final = prm_val(:,i) - prmval(i) ;
    scatter([1:length(prm_val)],Diff_final,[45],clrgrd,'filled'), hold on

end 
ttl = title(['OSSE of 1 Parameter: ' prmtr]); ttl.Color = TxtClr;
xlabel('Parameter Index'), ylabel('Diff [ p_i - p_{o} ]')
 
ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

colormap cool
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='southoutside';