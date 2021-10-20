%% Plotting the 10% parameter optimization cases

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
FileLoc = '../PE-Runs/OSSE-1D-02Prm-17StVr-FRCGwNorm-dt400-Prm_p_pe_R1c-z_sd-10percpert/PEOutput.dat';

% Parameter Set in OSSE experiment %
% - Parameters Being Tested
prmtrs = {'p\_pe\_R1c','z\_sd'};
% - Parameter reference values
nom_prm_val = [0.2,0.5];

% Optimization output data formatting parameters
delimiter = ' ';
hdr_lines = 1;

temp = importdata(FileLoc,delimiter,hdr_lines);
data = temp.data;

[num_evl, num] = size(data);
num_prm = num - 1; 
% 
prm_vals = data(:,1:num_prm);
obj_val = data(:,num);

% Color Gradient for the progression of Optimization
clrgrd=[1:num_evl]/num_evl;

%%%%%%%%%%%%%%%%
% % Figure 1 % %
%%%%%%%%%%%%%%%%
f1 = figure(1);  f1.Color = FigClr; f1.InvertHardcopy = 'off';
scatter([1:length(obj_val)],obj_val,[45],'filled')

ttl = title('Optimization of RMSD'); ttl.Color = TxtClr;
ylabel('Objective Function, RMSD'), xlabel('Objective Function Evaluation')
%ylim([1 51])
% 
ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

%%%%%%%%%%%%%%%%
% % Figure 2 % % 
%%%%%%%%%%%%%%%%
% f2 = figure(2);  f2.Color = FigClr; f2.InvertHardcopy = 'off';
% scatter([1:length(obj_val)],obj_val,[45],clrgrd,'filled')
% 
% ttl = title('Optimization of RMSD'); ttl.Color = TxtClr;
% ylabel('Objective Function, RMSD'), xlabel('Objective Function Evaluation')
% 
% 
% ax = gca; ax.YScale='log';
% ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
% ax.Box = 'on'; ax.FontName = 'Times';
% 
% colormap cool

%%%%%%%%%%%%%%%%
% % Figure 3 % %
%%%%%%%%%%%%%%%%
f3 = figure(3); f3.Color = FigClr; f3.InvertHardcopy = 'off';
for i=1:num_prm
    Diff_final = prm_vals(:,i) - nom_prm_val(i) ;
    scatter([1:num_evl],Diff_final,[45],'filled'), hold on

end 
ttl = title('OSSE of 2 Parameters from Set 8'); ttl.Color = TxtClr;
xlabel('Parameter Index'), ylabel('Diff [ p_i - p_{o} ]')
yline(0) %, xlim([0 num_prm+1])
% 
ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

legend(prmtrs)