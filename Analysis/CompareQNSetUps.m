close all, clear all, clc

%% 51 Parameters
% Parameters
prmtrs = {'p\_PAR','p\_eps0','p\_epsR6','p\_pe\_R1c','p\_pe\_R1n','p\_pe\_R1p', ...
    'p\_sum','p\_srs','p\_sdmo','p\_thdo','p\_pu\_ea','p\_pu\_ra','p\_qun', ...
    'p\_lN4','p\_qnlc','p\_qncPPY','p\_xqn','p\_qup','p\_qplc','p\_qpcPPY',...
    'p\_xqp','p\_esNI','p\_res','p\_alpha\_chl','p\_qlcPPY','p\_epsChla', ...
    'z\_srs','z\_sum','z\_sdo','z\_sd','z\_pu','z\_pu\_ea','z\_chro','z\_chuc', ...
    'z\_minfood','z\_qpcMIZ','z\_qncMIZ','z\_paPPY','p\_sN4N3','p\_clO2o', ...
    'p\_sR6O3','p\_sR6N1','p\_sR6N4','p\_sR1O3','p\_sR1N1','p\_sR1N4','p\_rR6m', ...
    'NRT\_o2o','NRT\_n1p','NRT\_n3n','NRT\_n4n'};
% Parameter reference values
prmval = [0.5, 0.5, 0.5, 0.2, 0.44, 0.664, 0.2, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5421, 0.5, 0.6667, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.5, 0.431, 0.258, 1.0, 0.5, ...
    1.0, 0.125, 0.125, 0.125, 0, 0, 0, 0.1, 0.12, 0.12, 0.12, 0.1];


%% 

BaseCase_Dir = '51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4.mat';

MSCase_Dir = {'51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4-MS1.mat', ...
    '51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4-MS1e-1.mat', ...
    '51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4-MS2e-1.mat', ...
    '51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4-MS5e-1.mat'};

MFCase_Dir = {'51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4-el_bakry.mat', ...
    '51Prm-OSSE-NrmRfSTD-GS1e-5-CC1e-4-van_shanno.mat'};

BC_Temp = load(['OptResults/' BaseCase_Dir]);
FnlVals_BC = BC_Temp.FnlVals; FnlDifs_BC = BC_Temp.FnlDifs;
clear BC_Temp

for i = 1:length(MSCase_Dir)
    Temp = load(['OptResults/' MSCase_Dir{i}]);
    FnlVals_MS(i,:) = Temp.FnlVals; FnlDifs_MS(i,:) = Temp.FnlDifs;
end
    clear Temp
    
for i = 1:length(MFCase_Dir)
    Temp = load(['OptResults/' MFCase_Dir{i}]);
    FnlVals_MF(i,:) = Temp.FnlVals; FnlDifs_MF(i,:) = Temp.FnlDifs;
end
    clear Temp

% Figure 1 : 
% Plot of Final Optimization Values
f1 = figure(1);
scatter([1:51],prmval,'*'), hold on
scatter([1:51],FnlVals_BC,'filled')
for i = 1:length(MSCase_Dir)
    scatter([1:51],FnlVals_MS(i,:),'filled')
end

ttl = title('Final Normalized Parameter Values from OSSE');
yl = ylabel('Normalized Parameter Value'); 
xlim([0 52])

legend('Nom','BC','MS = 1.0','MS = 0.1','MS = 0.2','MS = 0.5')
set(gca,'xtick',1:length(prmtrs),'Xticklabel',prmtrs,'xticklabelrotation',270);


% Figure 2 : 
% Plot of Difference Values
f2 = figure(2);
scatter([1:51],FnlDifs_BC,'filled'), hold on
for i = 1:length(MSCase_Dir)
    scatter([1:51],FnlDifs_MS(i,:),'filled')
end

ttl = title('Final Parameter Differences from Nominal Values, Normalized');
yl = ylabel({'Difference in Normalized Parameter Values';'p_{opt} - p_{o}'});
ln = line([0 52],[0 0]); ln.Color = 'k';

xlim([0 52])

legend('BC','MS = 1.0','MS = 0.1','MS = 0.2','MS = 0.5')
set(gca,'xtick',1:length(prmtrs),'Xticklabel',prmtrs,'xticklabelrotation',270);


% Figure 3 : 
% Plot of Final Optimization Values
f3 = figure(3);
scatter([1:51],prmval,'*'), hold on
scatter([1:51],FnlVals_BC,'filled')
for i = 1:length(MFCase_Dir)
    scatter([1:51],FnlVals_MF(i,:),'filled')
end

ttl = title('Final Normalized Parameter Values from OSSE');
yl = ylabel('Normalized Parameter Value'); 
xlim([0 52])

legend('Nom','argaez\_tapia','el\_bakry','van\_shanno')
set(gca,'xtick',1:length(prmtrs),'Xticklabel',prmtrs,'xticklabelrotation',270);


% Figure 4 : 
% Plot of Difference Values
f4 = figure(4);
scatter([1:51],FnlDifs_BC,'filled'), hold on
for i = 1:length(MFCase_Dir)
    scatter([1:51],FnlDifs_MF(i,:),'filled')
end

ttl = title('Final Parameter Differences from Nominal Values, Normalized');
yl = ylabel({'Difference in Normalized Parameter Values';'p_{opt} - p_{o}'});
ln = line([0 52],[0 0]); ln.Color = 'k';

xlim([0 52])

legend('argaez\_tapia','el\_bakry','van\_shanno')
set(gca,'xtick',1:length(prmtrs),'Xticklabel',prmtrs,'xticklabelrotation',270);