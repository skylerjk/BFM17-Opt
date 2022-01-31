close all; clear all; clc

%% Directory and file names %%
dir = '../../Analysis/PlotSiteData/Data-BATS/Data_Opt_ML/';
dir_org = '../../BFM17_POM1D/bfm_run/bfm17_pom1d_bats/';
dir_opt = '../MS-Runs/BATS-29Prm-6objs-NrmRfSTD/OptRun/';

%% Figure data format %%
depth  = 150;                                 %plotting depth
numyr = 1;
styr = 2;
st = 360*styr+1; et = 360*(styr+numyr);

%% Load Observation Data %%

% Chlorophyll
load([dir 'Chla_1yr_climatology.mat'])
data_obs(1,:,:) = Var(1:1:depth,:); clear Var;
% Oxygen
load([dir 'Oxy_1yr_climatology.mat'])
data_obs(2,:,:) = Var(1:1:depth,:); clear Var;
% Nitrate
load([dir 'Nitrate_1yr_climatology.mat'])
data_obs(3,:,:) = Var(1:1:depth,:); clear Var;
% Phosphate
load([dir 'Phos_1yr_climatology.mat'])
data_obs(4,:,:) = Var(1:1:depth,:); clear Var;
% Particulate Organic Nitrogen
load([dir 'PON_1yr_climatology.mat'])
data_obs(5,:,:) = Var(1:1:depth,:); clear Var;
% Net Primary Production
load([dir 'NPP_1yr_climatology.mat'])
data_obs(6,:,:) = Var(1:1:depth,:); clear Var;

%% Load BFM17 Data %%
fil = 'bfm17_pom1d_bats.nc';

% Chlorophyll
tmp(1,:,:) = ncread([dir_org fil],'Chla');
% Oxygen
tmp(2,:,:) = ncread([dir_org fil],'O2o');
% Nitrate
tmp(3,:,:) = ncread([dir_org fil],'N3n');
% Phosphate
tmp(4,:,:) = ncread([dir_org fil],'N1p');
% Particulate Organic Nitrogen
tmp(5,:,:) = ... %ncread([dir_org fil],'P2n');
ncread([dir_org fil],'P2n') + ncread([dir_org fil],'Z5n') + ncread([dir_org fil],'R6n');
% Net Primary Production
tmp(6,:,:) = ncread([dir_org fil],'ruPTc') - ncread([dir_org fil],'resPP') - ncread([dir_org fil],'resZT');

data_org(1,:,:) = tmp(1,:,st:et);
data_org(2,:,:) = tmp(2,:,st:et);
data_org(3,:,:) = tmp(3,:,st:et);
data_org(4,:,:) = tmp(4,:,st:et);
data_org(5,:,:) = tmp(5,:,st:et);
data_org(6,:,:) = tmp(6,:,st:et)./12.0;

clear tmp

%% Load Optimized BFM17 Data %%
fil = 'bfm17_pom1d.nc';

% Chlorophyll
tmp(1,:,:) = ncread([dir_opt fil],'Chla');
% Oxygen
tmp(2,:,:) = ncread([dir_opt fil],'O2o');
% Nitrate
tmp(3,:,:) = ncread([dir_opt fil],'N3n');
% Phosphate
tmp(4,:,:) = ncread([dir_opt fil],'N1p');
% Particulate Organic Nitrogen
tmp(5,:,:) = ... 
ncread([dir_opt fil],'P2n') + ncread([dir_opt fil],'Z5n') + ncread([dir_opt fil],'R6n');
% Net Primary Production
tmp(6,:,:) = ncread([dir_opt fil],'ruPTc') - ncread([dir_opt fil],'resPP') - ncread([dir_opt fil],'resZT');


data_opt(1,:,:) = tmp(1,:,st:et);
data_opt(2,:,:) = tmp(2,:,st:et);
data_opt(3,:,:) = tmp(3,:,st:et);
data_opt(4,:,:) = tmp(4,:,st:et);
data_opt(5,:,:) = tmp(5,:,st:et);
data_opt(6,:,:) = tmp(6,:,st:et)./12.0;

clear tmp
%% Data Averages %% 

AvgData_org = zeros(6,depth,12);
AvgData_opt = zeros(6,depth,12); 
for n = 1:6
    for k = 1:numyr
        for j = 1:12
            for m = 1:30
                AvgData_org(n,1:depth,j) = AvgData_org(n,1:depth,j) ...
                    + data_org(n,1:depth,m + (j-1)*30 + (k-1)*360);
                % %
                AvgData_opt(n,1:depth,j) = AvgData_opt(n,1:depth,j) ...
                    + data_opt(n,1:depth,m + (j-1)*30 + (k-1)*360);
            end
        end
    end
end
AvgData_org = AvgData_org./(30*numyr); 
AvgData_opt = AvgData_opt./(30*numyr);

mu_obs = mean(mean(data_obs,2),3);
mu_org = mean(mean(AvgData_org,2),3);
mu_opt = mean(mean(AvgData_opt,2),3);

N = 1800;

for i = 1:6
    std_obs(i) = sqrt(sum(sum((data_obs(i,:,:)-mu_obs(i)).^2))/N);
    std_org(i) = sqrt(sum(sum((AvgData_org(i,:,:)-mu_org(i)).^2))/N);
    std_opt(i) = sqrt(sum(sum((AvgData_opt(i,:,:)-mu_opt(i)).^2))/N);
end

for i = 1:6
    cor_org(i) = (sum(sum((AvgData_org(i,:,:)-mu_org(i)).*(data_obs(i,:,:)-mu_obs(i))))/N)/(std_org(i)*std_obs(i));
    cor_opt(i) = (sum(sum((AvgData_opt(i,:,:)-mu_opt(i)).*(data_obs(i,:,:)-mu_obs(i))))/N)/(std_opt(i)*std_obs(i));
    % cor_com(i) = (sum(sum((AvgData_opt(i,:,:)-mu_opt(i)).*(AvgData_org(i,:,:)-mu_org(i))))/N)/(std_opt(i)*std_org(i));

end

    
for i = 1:6
    rmsd_org(i) = sqrt(sum(sum((AvgData_org(i,:,:) - data_obs(i,:,:)).^2))/N);
    rmsd_opt(i) = sqrt(sum(sum((AvgData_opt(i,:,:) - data_obs(i,:,:)).^2))/N);
    % rmsd_com(i) = sqrt(sum(sum((AvgData_org(i,:,:) - AvgData_opt(i,:,:)).^2))/N);
end
cor_org
cor_opt

rmsd_org
rmsd_opt

rmsd_org_nor = rmsd_org./std_obs; rmsd_opt_nor = rmsd_opt./std_obs;
std_org_nor = std_org./std_obs; std_opt_nor = std_opt./std_obs;

STDs = [ 1.0, std_org_nor , std_opt_nor];
CORs = [ 1.0, cor_org , cor_opt];
RMSs = [ 0.0, rmsd_org_nor, rmsd_opt_nor];

%% Figure format %%
leftx   = 0.05;                                     %panel left x location
lefty   = 0.075;                                    %panel left y location
width   = 5;                                        %figure width
height  = 3;                                        %figure height
widthx  = 0.95;                                     %panel widths
heighty = 0.95;                                     %panel height
tangle  = 103;                                      %figure line width
rmstic  = [1.0:1.0:4.0];                            %RMS ticks
stdtic  = [1.0:1.0:3.0];                            %STD ticks
cortic  = [0.0,0.2:0.2:0.8,0.95,1.0];               %CORR ticks
lincol  = [0.5 0.5 0.5];                            %line color

%% Figure
figure(1)
set(gcf,'units','inches','position',[12 2 width height],'color','w')
clf;
subplot('position',[leftx+0.15,lefty,widthx,heighty])

taylordiag(STDs,RMSs,CORs,'tickRMSangle',tangle,'tickRMS',rmstic,...
    'colRMS',lincol,'colCOR',lincol,'tickSTD',stdtic,...
    'colSTD',lincol,'tickCOR',cortic)

h = findobj(gca,'Type','line');
legend([h(12),h(11),h(10),h(9),h(8),h(7),h(6),h(5),h(4),h(3),h(2),h(1)],...
    'BFM17 - Chl-a','BFM17 - Oxy','BFM17 - Nit','BFM17 - Phos','BFM17 - PON','BFM17 - NPP',...
    'Opt - Chl-a','Opt - Oxy','Opt - Nit','Opt - Phos','Opt - PON','Opt - NPP',...
    'position',[0.02,0.4,0.2,0.25],'Interpreter','Latex','FontSize',9)
legend BOXOFF

%% Format and print %%
% set(gcf,'PaperPositionMode','auto','InvertHardCopy','off')
% print(gcf,'-dpng','-r600','figure7.png')

