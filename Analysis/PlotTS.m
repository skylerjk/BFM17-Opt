% PREAMPLE -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= %
% Clean Run of Code
close all, clear all, clc 

% Set color scheme for plots
ClrCase = 'Presentation';
switch ClrCase
    case 'Paper'
        FigClr = 'w'; AxsClr = 'k'; TxtClr = 'k';
        lbox = 'off';
    case 'Presentation'
        FigClr = 'k'; AxsClr = 'w'; TxtClr = 'w';
        lbox = 'off';
end
% =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= %

% Case Directory %
% =-=-=-=-=-=-=- %
EDir = '../PE-Runs/05Prm-OSSE-1D-COBYLAwNorm-1YrSim/evl_dir/';

RFil = 'Data/bfm17_pom1d-ref-1YrSim.nc';
IFil = 'IEval/bfm17_pom1d.nc';
FFil = 'FEval/bfm17_pom1d.nc';

% Load Reference Data %
RData(1,:,:) = ncread([EDir RFil],'P2l'); RData(2,:,:) = ncread([EDir RFil],'P2c');
RData(3,:,:) = ncread([EDir RFil],'Z5c'); RData(4,:,:) = ncread([EDir RFil],'R1c');
RData(5,:,:) = ncread([EDir RFil],'R6c'); RData(6,:,:) = ncread([EDir RFil],'N1p');
RData(7,:,:) = ncread([EDir RFil],'N3n'); RData(8,:,:) = ncread([EDir RFil],'N4n');
RData(9,:,:) = ncread([EDir RFil],'O2o');

% Load Initial Data %
IData(1,:,:) = ncread([EDir IFil],'P2l'); IData(2,:,:) = ncread([EDir IFil],'P2c');
IData(3,:,:) = ncread([EDir IFil],'Z5c'); IData(4,:,:) = ncread([EDir IFil],'R1c');
IData(5,:,:) = ncread([EDir IFil],'R6c'); IData(6,:,:) = ncread([EDir IFil],'N1p');
IData(7,:,:) = ncread([EDir IFil],'N3n'); IData(8,:,:) = ncread([EDir IFil],'N4n');
IData(9,:,:) = ncread([EDir IFil],'O2o');

% Load Final Data %
FData(1,:,:) = ncread([EDir FFil],'P2l'); FData(2,:,:) = ncread([EDir FFil],'P2c');
FData(3,:,:) = ncread([EDir FFil],'Z5c'); FData(4,:,:) = ncread([EDir FFil],'R1c');
FData(5,:,:) = ncread([EDir FFil],'R6c'); FData(6,:,:) = ncread([EDir FFil],'N1p');
FData(7,:,:) = ncread([EDir FFil],'N3n'); FData(8,:,:) = ncread([EDir FFil],'N4n');
FData(9,:,:) = ncread([EDir FFil],'O2o');

RefTtl = {'Ref. P2l','Ref. P2c','Ref. Z5c','Ref. R1c','Ref. R6c','Ref. N1p','Ref. N3n','Ref. N4n','Ref. O2o'};
IntTtl = {'Init. P2l','Init. P2c','Init. Z5c','Init. R1c','Init. R6c','Init. N1p','Init. N3n','Init. N4n','Init. O2o'};
FinTtl = {'Opt. P2l','Opt. P2c','Opt. Z5c','Opt. R1c','Opt. R6c','Opt. N1p','Opt. N3n','Opt. N4n','Opt. O2o'};

f1 = figure(1); f1.Color = FigClr; f1.InvertHardcopy = 'off';
for i = 1:9
    
    MinVal(i) = min(min(RData(i,:,:))); 
    MaxVal(i) = max(max(RData(i,:,:)));
    
    sp(1) = subplot(3,9,i);
    imagesc(squeeze(RData(i,:,:)))
    ttl = title(RefTtl(i)); ttl.Color = TxtClr;
    
    caxis([MinVal(i) MaxVal(i)])
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    sp(2) = subplot(3,9,9+i);
    imagesc(squeeze(IData(i,:,:))), caxis([MinVal(i) MaxVal(i)])
    ttl = title(IntTtl(i)); ttl.Color = TxtClr;
    
    caxis([MinVal(i) MaxVal(i)])
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    sp(3) = subplot(3,9,18+i); 
    imagesc(squeeze(IData(i,:,:) - RData(i,:,:)))
    ttl = title('Diff'); ttl.Color = TxtClr;
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    cb = colorbar;
    cb.Color = TxtClr; cb.Location ='southoutside';
    
    % Change colormaps
    colormap(sp(1),'cool')
    colormap(sp(2),'cool')
    colormap(sp(3),'jet')
    
end

f2 = figure(2); f2.Color = FigClr; f2.InvertHardcopy = 'off';
for i = 1:9
    
    sp(1) = subplot(3,9,i);
    imagesc(squeeze(RData(i,:,:))), caxis([MinVal(i) MaxVal(i)])
    ttl = title(RefTtl(i)); ttl.Color = TxtClr;
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    sp(2) = subplot(3,9,9+i);
    imagesc(squeeze(FData(i,:,:))), caxis([MinVal(i) MaxVal(i)])
    ttl = title(FinTtl(i)); ttl.Color = TxtClr;
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    sp(3) = subplot(3,9,18+i);
    imagesc(squeeze(FData(i,:,:) - RData(i,:,:)))
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    cb = colorbar;
    cb.Color = TxtClr; cb.Location ='southoutside';
    
    % Change colormaps
    colormap(sp(1),'cool')
    colormap(sp(2),'cool')
    colormap(sp(3),'jet')
    
end

f3 = figure(3); f3.Color = FigClr; f3.InvertHardcopy = 'off';
for i = 1:9
    
    sp(1) = subplot(3,9,i);
    imagesc(squeeze(IData(i,:,:))), caxis([MinVal(i) MaxVal(i)])
    ttl = title(IntTtl(i)); ttl.Color = TxtClr;
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    sp(2) = subplot(3,9,9+i);
    imagesc(squeeze(FData(i,:,:))), caxis([MinVal(i) MaxVal(i)])
    ttl = title(FinTtl(i)); ttl.Color = TxtClr;
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    sp(3) = subplot(3,9,18+i);
    imagesc(squeeze(FData(i,:,:) - IData(i,:,:)))
    ttl = title('Diff'); ttl.Color = TxtClr;
    
    ax = gca;
    ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
    ax.Box = 'on'; ax.FontName = 'Times'; 
    
    cb = colorbar;
    cb.Color = TxtClr; cb.Location ='southoutside';
    
    % Change colormaps
    colormap(sp(1),'cool')
    colormap(sp(2),'cool')
    colormap(sp(3),'jet')
end