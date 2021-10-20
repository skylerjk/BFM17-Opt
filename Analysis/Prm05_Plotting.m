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
% FileLoc = '../PE-Runs/OSSE-1D-05Prm-17StVr-FRCGwNorm-dt400-PrmSet1-10percpert/PEOutput.dat';
FileLoc = '../PE-Runs/OSSE-1D-05Prm-17StVr-FRCG-dt400-PrmSet8-10percpert/PEOutput.dat';
% % %% Parameter Set 1 %%
% % - Parameters Being Tested
% prmtrs = {'p_PAR','p_eps0', 'p_sum','z_sum','z_paPPY'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.2,0.25,1.0];

% %% Parameter Set 2 %%
% % - Parameters Being Tested
% prmtrs = {'p_PAR','p_eps0', 'p_sum','p_qup','z_sum'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.2,0.5,0.25];

% %% Parameter Set 3 %%
% % - Parameters Being Tested
% prmtrs = {'p_PAR','p_eps0', 'p_sum','p_alpha_chl','z_sum'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.2,0.5,0.25];

% %% Parameter Set 4 %%
% % - Parameters Being Tested
% prmtrs = {'p_PAR','p_sum','p_qncPPY','z_sum','z_qpcMIZ'};
% % - Parameter reference values
% prmval = [0.5,0.2,0.5,0.25,0.431];

% %% Parameter Set 5 %%
% % - Parameters Being Tested
% prmtrs = {'p_PAR','p_sum','p_qncPPY','z_sum','z_qncMIZ'};
% % - Parameter reference values
% prmval = [0.5,0.2,0.5,0.25,0.258];

% %% Parameter Set 6 %%
% % - Parameters Being Tested
% prmtrs = {'p_PAR','p_sum','p_srs','z_sum','z_srs'};
% % - Parameter reference values
% prmval = [0.5,0.2,0.5,0.25,0.25];

% %% Parameter Set 7 %%
% % - Parameters Being Tested
% prmtrs = {'p_PAR','z_sum','z_pu','z_paPPY','p_sR1O3'};
% % - Parameter reference values
% prmval = [0.5,0.25,0.5,1.0,0.0];

%% Parameter Set 8 %%
% - Parameters Being Tested
prmtrs = {'p_pe_R1c','p_qpcPPY','z_sd','p_sR6O3','p_sR1O3'};
% - Parameter reference values
prmval = [0.2,0.546,0.5,0.125,0.0];

% %% Parameter Set 9 %%
% % - Parameters Being Tested
% prmtrs = {'p_eps0','p_qpcPPY','z_sd','p_sR6O3','p_sR1O3'};
% % - Parameter reference values
% prmval = [0.567,0.546,0.5,0.125,0.0];

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
ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

colormap cool

%%%%%%%%%%%%%%%%
% % Figure 2 % % 
%%%%%%%%%%%%%%%%
f2 = figure(2);  f2.Color = FigClr; f2.InvertHardcopy = 'off';
scatter([1:length(obj_val)],obj_val,[45],clrgrd,'filled')

ttl = title('Optimization of RMSD'); ttl.Color = TxtClr;
ylabel('Objective Function, RMSD'), xlabel('Objective Function Evaluation')


ax = gca; ax.YScale='log';
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
% % Figure 3 % %
%%%%%%%%%%%%%%%%
f3 = figure(3); f3.Color = FigClr; f3.InvertHardcopy = 'off';
for i=1:num_prm
    Diff_final = prm_val(:,i) - prmval(i) ;
    scatter(i*ones(1,num_evl),Diff_final,[45],clrgrd,'filled'), hold on

end 
ttl = title('OSSE of 5 Parameters : Set 8 for Unnormalized Obj. Func.'); ttl.Color = TxtClr;
xlabel('Parameter Index'), ylabel('Diff [ p_i - p_{o} ]')
line([0 6],[0 0]), xlim([0 6])
% 
ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

colormap cool
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='southoutside';
