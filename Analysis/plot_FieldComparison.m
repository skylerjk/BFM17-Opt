close all; clear all; clc

%% Directory and file names %%
dir = '../../Analysis/PlotSiteData/Data-BATS/Data_ML/';
dir_org = '../../BFM17_POM1D/bfm_run/bfm17_pom1d_bats/';
dir_opt = '../../BFM17-OptRuns-Past/MS-Runs/BATS-29Prm-6objs-NrmRfSTD/OptRun/';

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

%% Load BFM56 Data %%
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


%% Figure format %%
xmin   = 0.5;                                       %x axis min value
xmax   = 12.5;                                      %x axis max value
clow   = [0,180,0,0,0.1,0];                         %value min
chigh  = [0.225,235,2.5,0.075,0.405,2.0];           %value max

ylab   = 'Depth (m)';                               %panel xlabel
xlab   = 'Months';                                  %panel ylabel
tit_op = {'(a) BATS Chl-a','(b) BATS Oxygen','(c) BATS Nit.',...
          '(d) BATS Phos.','(e) BATS PON','(f) BATS NPP'};
tit_17 = {'(g) BFM17 Chl-a','(h) BFM17 Oxygen','(i) BFM17 Nit.',...
          '(j) BFM17 Phos.','(k) BFM17 PON','(l) BFM17 NPP'};
tit_56 = {'(m) Opt Chl-a','(n) Opt Oxygen','(o) Opt Nit.',...
          '(p) Opt Phos.','(q) Opt PON','(r) Opt NPP'};

% % Colormap % %
map=cbrewer('seq', 'YlGnBu', 40, 'cubic');
map=flip(map);

xp      = 0.05;
xoff    = 0.16;
yp      = 0.14;
yoff    = 0.29;
wp      = 0.14;
hp      = 0.24;
width   = 7;                   %figure width
height  = 4.4;                 %figure height
tlen    = 0.02;                %figure tick length
lwidth  = 2;                   %figure line width
ty      = 0.08;

fname   = 'Times'; 
fsize   = 9;                   %figure font size

%% plot details %%
f1 = figure(1); 
f1.Units = 'inches'; f1.Position = [12 2 width height]; f1.Color = 'w';

for i = 1:6
    % Plot BATS Observational Fields %
    subplot('Position',[xp+(i-1)*xoff,yp+2*yoff,wp,hp]);
    imagesc(1:1:12,1:1:depth,squeeze(data_obs(i,:,:)))
    
    ax = gca;
    ax.Box = 'on'; ax.TickLength = [tlen,tlen];
    ax.FontName = fname; ax.FontSize = fsize-1; 
    ax.YDir = 'reverse';
    ax.XTick = [1:1:12]; ax.XTickLabel = {};

    if(i==1)
        ylabel(ylab,'Interpreter','Latex','FontSize',fsize)
    else
        set(gca,'YTickLabel',{}) 
    end
    xlim([xmin xmax]), ylim([0 depth])
    colormap(map)
    caxis([clow(i) chigh(i)])
    
    xt=get(gca,'xlim'); yt=get(gca,'ylim');
    text(xt(1),yt(1)+ty*(yt(1)-yt(2)),tit_op{i}, ...
         'Interpreter','latex','FontSize',fsize,'Color','k')
    
    % Plot Original BFM17 Results %
    subplot('Position',[xp+(i-1)*xoff,yp+1*yoff,wp,hp]);
    imagesc(1:1:12,1:1:depth,squeeze(AvgData_org(i,:,:)))
    
    ax = gca;
    ax.Box = 'on'; ax.TickLength = [tlen,tlen];
    ax.FontName = fname; ax.FontSize = fsize-1; 
    ax.YDir = 'reverse';
    ax.XTick = [1:1:12]; ax.XTickLabel = {};

    if(i==1)
        ylabel(ylab,'Interpreter','Latex','FontSize',fsize,'Color','k')
    else
        set(gca,'YTickLabel',{})
    end
    xlim([xmin xmax]), ylim([0 depth])
    colormap(map)
    caxis([clow(i) chigh(i)])
    
    xt=get(gca,'xlim'); yt=get(gca,'ylim');
    text(xt(1),yt(1)+ty*(yt(1)-yt(2)),tit_17{i}, ...
         'Interpreter','latex','FontSize',fsize,'Color','k')
    
    % Plot Optimized BFM17 Results %
    subplot('Position',[xp+(i-1)*xoff,yp+0*yoff,wp,hp]);
    imagesc(1:1:12,1:1:depth,squeeze(AvgData_opt(i,:,:)))
    
        
    ax = gca;
    ax.Box = 'on'; ax.TickLength = [tlen,tlen];
    ax.FontName = fname; ax.FontSize = fsize-1; 
    ax.YDir = 'reverse';
    ax.XTick = [1:1:12]; ax.XTickLabel = {'J','','M','','M','','J','','S','','N',''};
    
    if(i==1)
        ylabel(ylab,'Interpreter','Latex','FontSize',fsize)
    else
        set(gca,'YTickLabel',{})
    end
    
    xlabel(xlab,'Interpreter','Latex','FontSize',fsize)
    xlim([xmin xmax]), ylim([0 depth])
    colormap(map)
    caxis([clow(i) chigh(i)])
    
    xt=get(gca,'xlim'); yt=get(gca,'ylim');
    text(xt(1),yt(1)+ty*(yt(1)-yt(2)),tit_56{i}, ...
         'Interpreter','latex','FontSize',fsize,'Color','k')
    
    % % Adding the colorbars % %
    colorbar(gca,'Location','SouthOutside',...
    'Position',[xp+(i-1)*xoff,0.04,wp,0.03],...
    'FontName','Times',...
    'FontSize',fsize-1,...
    'Color','k')
end

set(gcf,'PaperPositionMode','auto')
set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize',[width height]);
set(gcf, 'InvertHardCopy', 'off');
papersize = get(gcf,'PaperSize');
left = (papersize(1)-width)/2;
bottom = (papersize(2)-height)/2;
myfiguresize = [left,bottom,width,height];
set(gcf,'PaperPosition',myfiguresize);
%print(gcf,'-dpng','-r600',['Plot/figure6.png'])
%save(['Plot/figure6_new.png'])

%% Calculating  

