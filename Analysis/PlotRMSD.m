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

% Case Directory
% =-=-=-=-=-=-= %
Dir = '../PE-Runs/05Prm-Set6-OSSE-1D-FRCGwNorm/';

% Opt Directory 
ObjDr = 'opt_dir/PEOutput.dat';
% Initial Evaluation of Model
IEval = 'evl_dir/IEval/EvlResults.out';
% Final Evaluation of Model
FEval = 'evl_dir/FEval/EvlResults.out';

prm_val_nom = [0.5, 0.2, 0.5, 0.25, 0.25];
PrmNms = {'p\_PAR','p\_sum','p\_srs','z\_sum','z\_srs'};

% % Load Optimization History % %
% =-=-=-=-=-=-=-=-=-=-=-=-=-=-= %
delimiter = ' ';
hdr_lines = 1;

temp = importdata([Dir ObjDr],delimiter,hdr_lines);
data = temp.data; clear temp;

[num_evl, num] = size(data);
num_prm = num - 1; 
% 
prm_val = data(:,1:num_prm);
obj_val = data(:,num);

% %  Load Evaluation Results  % %
% =-=-=-=-=-=-=-=-=-=-=-=-=-=-= %
fid = fopen([Dir IEval],'r');
IRMSD = fscanf(fid,'%f');
fclose(fid);

fid = fopen([Dir FEval],'r');
FRMSD = fscanf(fid,'%f');
fclose(fid);

% Color Gradient for the progression of Optimization
clrgrd=[1:num_evl]/num_evl;

%%%%%%%%%%%%%%%%
% % Figure 1 % %
%%%%%%%%%%%%%%%%
% % Plot of initial RMSD values, with log scale on y-axis
% f1 = figure(1);  f1.Color = FigClr; f1.InvertHardcopy = 'off';
% scatter([1:17],IRMSD,[45],'c','filled')
% ttl = title('Initial RMSD Values'); ttl.Color = TxtClr;
% 
% ylabel('RMSD'); xlabel('State Variable')
%  
% ax = gca; ax.YScale='log';
% ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
% ax.Box = 'on'; ax.FontName = 'Times';
% 
% ax.XTick = [0:18];
% ax.XTickLabel = {[],'Pl','Pc',[],[],'Zc',[],[],'R1c',[],[],'R2c',[],[],'N1p','N2n','N3n','O2',[]};
% ax.XTickLabelRotation = 45;

%%%%%%%%%%%%%%%%
% % Figure 2 % %
%%%%%%%%%%%%%%%%
% Plot of final RMSD values, with log scale on y-axis
f2 = figure(2);  f2.Color = FigClr; f2.InvertHardcopy = 'off';
for i = 1:num_prm
    scatter([1:num_evl],prm_val(:,i),[45],'filled'), hold on
end

for i = 1:num_prm
    line([1 num_evl],[prm_val_nom(i) prm_val_nom(i)])
end
ylim([0 1]), xlim([1 num_evl])
ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

lg = legend(PrmNms);
lg.Color = FigClr; lg.TextColor = TxtClr; lg.Box = lbox; lg.FontSize = 10;

%%%%%%%%%%%%%%%%
% % Figure 2 % %
%%%%%%%%%%%%%%%%
% % Plot of final RMSD values, with log scale on y-axis
% f2 = figure(2);  f2.Color = FigClr; f2.InvertHardcopy = 'off';
% scatter([1:17],FRMSD,[45],'filled')
% 
% ax = gca; ax.YScale='log';
% ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
% ax.Box = 'on'; ax.FontName = 'Times';

%%%%%%%%%%%%%%%%
% % Figure 3 % %
%%%%%%%%%%%%%%%%
% % Plot of initial and final RMSD values
% f3 = figure(3);  f3.Color = FigClr; f3.InvertHardcopy = 'off';
% scatter([1:17],IRMSD,[45],'filled'), hold on
% scatter([1:17],FRMSD,[45],'filled')
% 
% ttl = title('RMSD Values from Optimization'); ttl.Color = TxtClr;
% ylabel('RMSD for State Variable'), xlabel('State Variable Index, [A_j]')
% 
% ax = gca; ax.YScale='log';
% ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
% ax.Box = 'on'; ax.FontName = 'Times';
% 
% lg = legend('Int. RMSD','Fin. RMSD');
% lg.Color = FigClr; lg.TextColor = TxtClr; lg.Box = lbox; lg.FontSize = 10;

%%%%%%%%%%%%%%%%
% % Figure 4 % %
%%%%%%%%%%%%%%%%
f4 = figure(4);  f4.Color = FigClr; f4.InvertHardcopy = 'off';
subplot(1,2,1)
scatter([1:length(obj_val)],obj_val,[45],clrgrd,'filled')
xlim([1 length(obj_val)])

ttl = title('Objective Function Evaluations'); ttl.Color = TxtClr;
ylabel('Summed RMSD for State Variables'), xlabel('Evaluation')

ax = gca; % ax.YScale='log';
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times'; 

colormap cool
cb = colorbar; cb.Label.String = 'Optimization Progression';
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='southoutside';

subplot(1,2,2), hold on
for i= 1:17
    pl = line([i i],[IRMSD(i) FRMSD(i)]);
    pl.LineStyle = '--'; pl.Color = 'c';
end
sc = scatter([1:17],IRMSD,[45],'c','filled'); 
hold on
scatter([1:17],FRMSD,[45],'m','filled','Marker','d')
xlim([0 18])

ttl = title('RMSD Values from Optimization'); ttl.Color = TxtClr;
ylabel('RMSD for State Variable'), xlabel('State Variable Index, [A_j]')

ax = gca; ax.YScale='log';
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';
ax.XTick = [0:18];
ax.XTickLabel = {[],'Pl','Pc',[],[],'Zc',[],[],'R1c',[],[],'R2c',[],[],'N1p','N2n','N3n','O2',[]};
ax.XTickLabelRotation = 45;

%%%%%%%%%%%%%%%%
% % Figure 5 % %
%%%%%%%%%%%%%%%%
f5 = figure(5);  f5.Color = FigClr; f5.InvertHardcopy = 'off';
for i=1:num_prm
    Diff_final = prm_val(:,i) - prm_val_nom(i);
    scatter(i*ones(1,num_evl),Diff_final,[45],clrgrd,'filled'), hold on

end

ttl = title('OSSE of 51 Parameters'); ttl.Color = TxtClr;
xlabel('Parameter Index'), ylabel('Diff, Val - Nom Val')
line([0 6],[0 0]), xlim([0 6])
% 
ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times';

colormap cool
cb = colorbar;
cb.Limits =[0.,1.]; cb.Ticks=[0,1]; cb.TickLabels = {'Beginning','End'};
cb.Color = TxtClr; cb.Location ='southoutside';


ax.XTick = [0:6];
ax.XTickLabel = {[],PrmNms{1},PrmNms{2},PrmNms{3},PrmNms{4},PrmNms{5},[]};
ax.XTickLabelRotation = 45;
