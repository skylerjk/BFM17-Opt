%% Plotting the 10% parameter optimization cases

close all, clear all, clc

% Set color scheme for plots
FigClr = 'w'; 
AxsClr = 'k'; 
TxtClr = 'k';
lbox = 'off';

% % Directory Information % %
% FileLoc = '../PE-Runs/OSSE-1D-10Prm-17StVr-OpQNwNorm-dt400-PrmSet13-10percpert-Norm_RefSTD-GS1e-5-CC1e-10/PEOutput.dat';

% FileLoc = '../QN-Runs/OSSE-10Prm-17StVr-dt400-PrmSet13-10perc-NrmRfSTD-GS1e-5-CC1e-04/PEOutput.dat';
% FileLoc = '../QN-Runs/OSSE-51Prm-17StVr-dt400-PrmSetAll-10perc-NrmRfSTD-GS1e-5-CC1e-04/PEOutput.dat';
% FileLoc = '../QN-Runs/OSSE-29Prm-17StVr-10perc-NrmRfSTD-TestingMostSensitive/PEOutput.dat';

FileLoc = '../MS-Runs/Test-bats-correctedObjFunc/PEOutput.dat';

% FileLoc = '../PE-Runs/OSSE-1D-03Prm-17StVr-FRCGwNorm-dt400-PrmSet10A-025percpert-Norm_RefSTD/PEOutput.dat';
% FileLoc = '../PE-Runs/OSSE-1D-03Prm-17StVr-OpCGwNorm-dt400-PrmSet10A-10percpert-Norm_RefSTD-GS1e-4-CC1e-10/PEOutput.dat';
% FileLoc = '../PE-Runs/OSSE-1D-02Prm-17StVr-FRCGwNorm-dt400-p_qup-z_sd-10percpert-Norm_RefSTD-GS1e-4/PEOutput.dat';

% Opt_Text = 'Test Alt Merit Function: van\_shanno'; % 'Test Decreasing Max Step : 0.5';
Opt_Text = 'Ref. STD Normalized Opt++ Quasi-Newton - FD Step Size 1E-5 & Conv. Criteria 1E-4';
% Opt_Text = 'Ref. STD Normalized Opt++ Con Grad - Alt Prm Norm - FD Step Size 1E-3 & Conv. Criteria 1E-6'; % '; %     
YL_Text = 'Total Normalized RMSD';

% FileLoc = '../PE-Runs/OSSE-1D-05Prm-17StVr-COBYLAwNorm-dt400-PrmSet10-10percpert-Norm_RefSTD-ID_25/PEOutput.dat';
% FileLoc = '../PE-Runs/OSSE-1D-02Prm-17StVr-COBYLAwNorm-dt400-p_qup-z_sd-10percpert-Norm_RefSTD-ID_5/PEOutput.dat';

% Opt_Text = 'COBYLA Normalized by Standard Deviation of Reference Field';
% Opt_Text = 'COBYLA - Small Initial Delta Normalization by STD of Ref. Field';
% YL_Text = 'Total Normalized RMSD'; 

% %% Parameter Set 10 %%
% % - Parameters Being Tested
% prmtrs = {'p\_qup','p\_qplc','p\_qpcPPY','z\_sd','p\_sR6N1'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.542,0.5,0.125];
% prmval = [1.0,1.0,1.0,1.0,1.0];

% %% Parameter Set 10A %%
% % - Parameters Being Tested
% prmtrs = {'p\_qup','p\_qplc','p\_qpcPPY'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.542];

% prmtrs = {'p\_qup','z\_sd'};
% prmval = [0.5,0.5];


% Opt_Text = 'COBYLA without Normalization';
% YL_Text = 'Total RMSD'; 

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

% %% Parameter Set 8 %%
% % - Parameters Being Tested
% prmtrs = {'p\_pe\_R1c','p\_qpcPPY','z\_sd','p\_sR6O3','p\_sR1O3'};
% % - Parameter reference values
% prmval = [0.2,0.546,0.5,0.125,0.0];

% %% Parameter Set 9 %%
% % - Parameters Being Tested
% prmtrs = {'p_eps0','p_qpcPPY','z_sd','p_sR6O3','p_sR1O3'};
% % - Parameter reference values
% prmval = [0.567,0.546,0.5,0.125,0.0];

% %% Parameter Set 10 %%
% % - Parameters Being Tested
% prmtrs = {'p\_qup','p\_qplc','p\_qpcPPY','z\_sd','p\_sR6N1'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.542,0.5,0.125];

% %% Parameter Set 10A %%
% % - Parameters Being Tested
% prmtrs = {'p\_qup','p\_qplc','p\_qpcPPY'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.542];

% %% Parameter Set 10B %%
% % - Parameters Being Tested
% prmtrs = {'p\_qup','z\_sd','p\_sR6N1'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.125];

% %% Parameter Set 10C %%
% % - Parameters Being Tested
% prmtrs = {'p\_qplc','z\_sd','p\_sR6N1'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.125];

% %% Parameter Set 10D %%
% % - Parameters Being Tested
% prmtrs = {'p\_qpcPPY','z\_sd','p\_sR6N1'};
% % - Parameter reference values
% prmval = [0.542,0.5,0.125];

% %% Parameter Set 10E %%
% % - Parameters Being Tested
% prmtrs = {'p\_qplc','p\_qpcPPY','z\_sd','p\_sR6N1'};
% % - Parameter reference values
% prmval = [0.5,0.542,0.5,0.125];

% %% Parameter Set 11 %%
% % - Parameters Being Tested
% prmtrs = {'p\_eps0','p\_qup','p\_qplc','p\_qpcPPY','z\_sd'};
% % - Parameter reference values
% prmval = [0.5,0.5,0.5,0.542,0.5];

% % %% Parameter Set 12 %%
% % % - Parameters Being Tested
% prmtrs = {'p\_eps0','p\_qup','p\_qplc','p\_qpcPPY','z\_sd','p\_sR6N1'};
% % % - Parameter reference values
% prmval = [0.5,0.5,0.5,0.542,0.5,0.125];

% % %% Parameter Set 13 %%
% % % - Parameters Being Tested
% prmtrs = {'p\_eps0','p\_qup','p\_qplc','p\_qpcPPY','p\_qlcPPY','z\_srs','z\_sd','p\_sR6N1','p\_sR1N1','p\_sR1N4'};
% % % - Parameter reference values
% prmval = [0.5,0.5,0.5,0.542,0.5,0.25,0.5,0.125,0.0,0.0];

% % %% Parameter Set 14 %%
% % % - Parameters Being Tested
% prmtrs = {'p\_PAR','p\_eps0','p\_qncPPY','p\_qup','p\_qplc','p\_qpcPPY','p\_alpha\_chl','p\_qlcPPY','z\_srs','z\_sd','p\_sR6N1','p\_sR6N4','p\_sR1O3','p\_sR1N1','p\_sR1N4'};
% % % - Parameter reference values
% prmval = [0.5,0.5,0.5,0.5,0.5,0.542,0.5,0.5,0.25,0.5,0.125,0.125,0.0,0.0,0.0];

% % %% Parameter Set 14A %%
% % % - Parameters Being Tested
% prmtrs = {'p\_PAR','p\_eps0','p\_qncPPY','p\_qup','p\_qplc','p\_qpcPPY','p\_qlcPPY','z\_srs','z\_sd','p\_sR6N1','p\_sR6N4','p\_sR1O3','p\_sR1N1','p\_sR1N4'};
% % % - Parameter reference values
% prmval = [0.5,0.5,0.5,0.5,0.5,0.542,0.5,0.25,0.5,0.125,0.125,0.0,0.0,0.0];

% % % %% Parameter Set 14B %%
% % % - Parameters Being Tested
% prmtrs = {'p\_eps0','p\_qncPPY','p\_qup','p\_qplc','p\_qpcPPY','p\_alpha\_chl','p\_qlcPPY','z\_srs','z\_sd','p\_sR6N1','p\_sR6N4','p\_sR1O3','p\_sR1N1','p\_sR1N4'};
% % % - Parameter reference values
% prmval = [0.5,0.5,0.5,0.5,0.542,0.5,0.5,0.25,0.5,0.125,0.125,0.0,0.0,0.0];

% % %% Parameter Set 15 %%
% % % - Parameters Being Tested
% prmtrs = {'p\_PAR','p\_eps0','p\_pe\_R1p','p\_srs','p\_sdmo','p\_qncPPY','p\_xqn','p\_qup','p\_qplc','p\_qpcPPY','p\_alpha\_chl','p\_qlcPPY','z\_srs','z\_sd','p\_sR6O3','p\_sR6N1','p\_sR6N4','p\_sR1O3','p\_sR1N1','p\_sR1N4'};
% % % - Parameter reference values
% prmval = [0.5,0.5,0.664,0.5,0.5,0.5,0.5,0.5,0.5,0.542,0.5,0.5,0.25,0.5,0.125,0.125,0.125,0.0,0.0,0.0];

% %% Parameter Set All
% % - Parameters Being Tested
prmtrs = {'p\_PAR','p\_eps0','p\_epsR6','p\_pe\_R1c','p\_pe\_R1n','p\_pe\_R1p', ...
    'p\_sum','p\_srs','p\_sdmo','p\_thdo','p\_pu\_ea','p\_pu\_ra','p\_qun', ...
    'p\_lN4','p\_qnlc','p\_qncPPY','p\_xqn','p\_qup','p\_qplc','p\_qpcPPY',...
    'p\_xqp','p\_esNI','p\_res','p\_alpha\_chl','p\_qlcPPY','p\_epsChla', ...
    'z\_srs','z\_sum','z\_sdo','z\_sd','z\_pu','z\_pu\_ea','z\_chro','z\_chuc', ...
    'z\_minfood','z\_qpcMIZ','z\_qncMIZ','z\_paPPY','p\_sN4N3','p\_clO2o', ...
    'p\_sR6O3','p\_sR6N1','p\_sR6N4','p\_sR1O3','p\_sR1N1','p\_sR1N4','p\_rR6m', ...
    'NRT\_o2o','NRT\_n1p','NRT\_n3n','NRT\_n4n'};
% % - Parameter reference values
prmval = [0.5, 0.5, 0.5, 0.2, 0.44, 0.664, 0.2, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5421, 0.5, 0.6667, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.5, 0.431, 0.258, 1.0, 0.5, ...
    1.0, 0.125, 0.125, 0.125, 0, 0, 0, 0.1, 0.12, 0.12, 0.12, 0.1];

% % %% Parameter Set Reduced
% % % - Parameters Being Tested
% prmtrs = {'p\_PAR','p\_eps0','p\_pe\_R1c','p\_pe\_R1n',...
%     'p\_pe\_R1p','p\_sum','p\_srs','p\_sdmo',...
%     'p\_thdo','p\_pu\_ra','p\_qun','p\_qncPPY',...
%     'p\_xqn','p\_qplc','p\_qpcPPY','p\_xqp',...
%     'p\_alpha\_chl','p\_qlcPPY','z\_srs','z\_sd',...
%     'z\_pu\_ea','p\_sN4N3', 'p\_sR6O3','p\_sR6N1',...
%     'p\_sR6N4','p\_sR1O3','p\_sR1N1','p\_sR1N4','p\_rR6m'};
% % % - Parameter reference values
% prmval = [0.5, 0.5, 0.2, 0.44, ...
%     0.664, 0.2, 0.5, 0.5,...
%     0.5, 0.5, 0.5, 0.5, ...
%     0.5, 0.5, 0.5421, 0.5, ...
%     0.5, 0.5, 0.25, 0.5, ...
%     0.5, 0.5, 0.125, 0.125, ...
%     0.125, 0, 0, 0, 0.1];

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
% plot([1:length(obj_val)],obj_val,'b-o')
sc = scatter([1:length(obj_val)],obj_val,[45],clrgrd,'filled');
sc.MarkerEdgeColor = [0.5 0.5 0.5];

% ttl = title('Prm Set 13 OSSE: Objective Function Evaluations',Opt_Text); ttl.Color = TxtClr;
% ttl = title('51 Parameter OSSE: Objective Function Evaluations',Opt_Text); ttl.Color = TxtClr;
% ttl = title('29 Parameter OSSE: Objective Function Evaluations',Opt_Text); ttl.Color = TxtClr;
ttl = title('Parameter Estimation with BATS Data: Objective Function Evaluations',Opt_Text);

% ttl = title('Prm Set 10A OSSE: Objective Function Evaluations',Opt_Text); ttl.Color = TxtClr;
% ttl = title('2 Prm OSSE from Set 10: Objective Function Evaluations',Opt_Text); ttl.Color = TxtClr;
yl = ylabel({'Objective Function';YL_Text});
xl = xlabel('Optimization Index');
% ylim([0.0 1.0])

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

colormap gray

%%%%%%%%%%%%%%%%
% % Figure 2 % %
%%%%%%%%%%%%%%%%
f2 = figure(2); f2.Color = FigClr; f2.InvertHardcopy = 'off'; hold on
for i=1:num_prm
    Diff_final = prm_val(:,i) - prmval(i) ;
    sc = scatter(i*ones(1,num_evl),Diff_final,[45],clrgrd,'filled');
    sc.MarkerEdgeColor = [0.5 0.5 0.5];;

end
% ttl = title('Prm Set 13 OSSE: Difference in Normalized Parameter Values',Opt_Text);
% ttl = title('51 Parameter OSSE: Difference in Normalized Parameter Values',Opt_Text);
% ttl = title('29 Parameter OSSE: Difference in Normalized Parameter Values',Opt_Text);
ttl = title('Parameter Estimation with BATS Data: Difference in Normalized Parameter Values',Opt_Text);
 
ttl.Color = TxtClr;

yl = ylabel({'Difference in Normalized Parameter Value';'p_{i} - p_{o}'}); 
% xl = xlabel('Parameter Index'); 

yline(0)
xlim([0 length(prmtrs)+0.5])

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

set(gca,'xtick',1:length(prmtrs),'Xticklabel',prmtrs,'xticklabelrotation',270);

colormap gray
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='eastoutside';

% FnlVals =  prm_val(num_evl,:);
% FnlDifs = prm_val(num_evl,:) - prmval;
% save('OptResults/51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4-van_shanno.mat','FnlVals','FnlDifs')

%%%%%%%%%%%%%%%%
% % Figure 3 % %
%%%%%%%%%%%%%%%%
% Reordering the final result plot with respect to most sensitive
% parameters
Temp = load('ParameterIndexOrder.mat'); 
Index = Temp.Prm_Ind_Srt2;

for i = 1:length(Index)
    prmtrs_ord{i} = prmtrs{Index(i)};
	
    prmval_ord(i) = prmval(Index(i));

    prm_val_ord(:,i) = prm_val(:,Index(i));
end

f3 = figure(3); f3.Color = FigClr; f3.InvertHardcopy = 'off'; hold on
for i=1:num_prm
    Diff_final = prm_val_ord(:,i) - prmval_ord(i) ;
    sc = scatter(i*ones(1,num_evl),Diff_final,[45],clrgrd,'filled');
    sc.MarkerEdgeColor = [0.5 0.5 0.5];

end 
% ttl = title('51 Parameter OSSE: Difference in Normalized Parameter Values','Parameters Ordered based on Sensitivity Analysis Ranking');
ttl = title('Parameter Estimation with BATS Data: Difference in Normalized Parameter Values','Parameters Ordered based on Sensitivity Analysis Ranking');
ttl.Color = TxtClr;

yl = ylabel({'Difference in Normalized Parameter Value';'p_{i} - p_{o}'}); 
% xl = xlabel('Parameters'); 

yline(0)
xlim([0 length(prmtrs)+0.5])

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

set(gca,'xtick',1:length(prmtrs_ord),'Xticklabel',prmtrs_ord,'xticklabelrotation',270);

colormap bone
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='eastoutside';