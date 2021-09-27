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
FileLoc = '../PE-Runs/OSSE-1D-05Prm-17StVr-FRCG/PEOutput.dat';

% - Parameters Being Tested
prmtrs = {'p_PAR','p_eps0', 'p_sum','z_sum','z_paPPY'};

% - Parameter reference values
prmval = [0.5,0.5,0.2,0.25,1.0];

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
ttl = title('OSSE of 51 Parameters'); ttl.Color = TxtClr;
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

% for prm = 1:length(prmtrs)
%     for opt = 1:4
%         
%         if prm < 10    
%             temp = importdata([BaseDir 'Var0' num2str(prm) '-' prmtrs{prm} '/OSSE_01Var_' prmtrs{prm} OptSfx{opt} FileLoc],delimiter,hdr_lines);
%         else
% 
%         end
% 
% 
%         data = temp.data;
% 
%         [num_evl, num] = size(data);
%         num_prm = num - 1; 
% 
%         prm_val = data(:,1:num_prm);
%         obj_val = data(:,num);
% 
% 
%         FinalData(prm,opt,1) = data(1);
%         FinalData(prm,opt,2) = data(length(data));
% 
% 
%     end
% end 
% 
% MrkClrs = {'r','m','c','b'};
% 
% f1 = figure(1); f1.Color = FigClr; f1.InvertHardcopy = 'off';
% % Plot Nominal Values
% scatter(prmval,[1:length(prmtrs)],70,'filled','d','g'), hold on
% for i = 1:4
%     scatter(FinalData(:,i,1),[1:length(prmtrs)],'filled','o',MrkClrs{i})
%     scatter(FinalData(:,i,2),[1:length(prmtrs)],'filled','d',MrkClrs{i})
% end
% % scatter(Final_Data_neg(:,1),[1:length(prmtrs)],'filled','o','r')
% % scatter(Final_Data_neg(:,2),[1:length(prmtrs)],'filled','d','r')
% % 
% % scatter(Final_Data_pos(:,1),[1:length(prmtrs)],'filled','o','b')
% % scatter(Final_Data_pos(:,2),[1:length(prmtrs)],'filled','d','b')
% % 
% ttl = title('Single Parameter Optimization Sets'); ttl.Color = TxtClr;
% ylabel('Parameter Index'), xlabel('Normalized Parameter Value')
% ylim([1 51])
% % 
% ax = gca; ax.YDir = 'reverse';
% ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
% ax.Box = 'on'; ax.FontName = 'Times';