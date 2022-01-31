close all, clear all, clc

% Set color scheme for plots
FigClr = 'w'; 
AxsClr = 'k'; 
TxtClr = 'k';
lbox = 'off';

format long

File_Location = '../QN-Runs/OSSE-51Prm-17StVr-dt400-PrmSetAll-10perc-NrmRfSTD-GS1e-5-CC1e-04-MltStr/';
MltStrts = 5; 

% %% Parameter Set All
Parameter_List = ...
    {'p_PAR', '$\varepsilon_{\mathrm{PAR}}$'; ...
      'p_eps0', '$\lambda _w$'; ...
      'p_epsR6', '$c_{R^(2)}$'; ...
      'p_pe_R1c', '$\varepsilon_{Z}^{(\mathrm{C})}$'; ...
      'p_pe_R1n', '$\varepsilon_{Z}^{(\mathrm{N})}$'; ...
      'p_pe_R1p', '$\varepsilon_{Z}^{(\mathrm{P})}$'; ...
      'p_sum', '$r_P^{(0)}$'; ...
      'p_srs', '$b_P$'; ...
      'p_sdmo', '$d_P^{(0)}$'; ...
      'p_thdo', '$h_P^{(\mathrm{N,P})}$'; ...
      'p_pu_ea', '$\beta_P$'; ...
      'p_pu_ra', '$\gamma_P$'; ...
      'p_qun', '$a_P^{(\mathrm{N})}$'; ...
      'p_lN4', '$h_P^{(\mathrm{N})}$'; ...
      'p_qnlc', '$\phi_{\mathrm{N}}^{(\mathrm{mn})}$';...
      'p_qncPPY','$\phi_{\mathrm{N}}^{(\mathrm{op})}$'; ...
      'p_xqn', '$\phi_{\mathrm{N}}^{(\mathrm{mx})}$'; ...
      'p_qup', '$a_P^{(\mathrm{P})}$'; ...
      'p_qplc', '$\phi_{\mathrm{P}}^{(\mathrm{mn})}$'; ...
      'p_qpcPPY', '$\phi_{\mathrm{P}}^{(\mathrm{op})}$'; ...
      'p_xqp', '$\phi_{\mathrm{P}}^{(\mathrm{mx})}$'; ...
      'p_esNI', '$l_P^{(\mathrm{sk})}$'; ...
      'p_res', '$w_P^{(\mathrm{sk})}$'; ...
      'p_alpha_chl', '$\alpha_{\mathrm{chl}}^{(0)}$'; ...
      'p_qlcPPY', '$\theta_{\mathrm{chl}}^{(0)}$'; ...
      'p_epsChla', '$c_P$'; ...
      'z_srs', '$b_Z$'; ...
      'z_sum', '$r_Z^{(0)}$'; ...
      'z_sdo', '$d_Z^{(0)}$'; ...
      'z_sd', '$d_Z$'; ...
      'z_pu', '$\eta_Z$'; ...
      'z_pu_ea', '$\beta_Z$'; ...
      'z_chro', '$h_Z^{(O)}$'; ...
      'z_chuc', '$h_Z^{(F)}$'; ...
      'z_minfood', '$\mu_Z$'; ...
      'z_qpcMIZ', '$\varphi_{\mathrm{P}}^{(\mathrm{op})}$'; ...
      'z_qncMIZ', '$\varphi_{\mathrm{N}}^{(\mathrm{op})}$'; ...
      'z_paPPY', '$\delta_Z$'; ...
      'p_sN4N3', '$\lambda_{N^{(3)}}^{(\mathrm{nit})}$'; ...
      'p_clO2o', '$h_N^{(O)}$'; ...
      'p_sR6O3', '$\xi_{\mathrm{CO}_2}$'; ...
      'p_sR6N1', '$\xi_{N^{(1)}}$'; ...
      'p_sR6N4', '$\xi_{N^{(2)}}$'; ...
      'p_sR1O3', '$\zeta_{\mathrm{CO}_2}$'; ...
      'p_sR1N1', '$\zeta_{N^{(1)}}$'; ...
      'p_sR1N4', '$\zeta_{N^{(2)}}$'; ...
      'p_rR6m', '$v^{(\mathrm{st})}$'; ...
      'NRT_o2o', '$\lambda_{O}$'; ...
      'NRT_n1p', '$\lambda_{N^{(1)}}$'; ...
      'NRT_n3n', '$\lambda_{N^{(2)}}$'; ...
      'NRT_n4n', '$\lambda_{N^{(3)}}$'};

Parameter_Labels = Parameter_List(:,2);

% % - Parameter reference values
PrmVal_Ref = [0.5, 0.5, 0.5, 0.2, 0.44, 0.664, 0.2, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5421, 0.5, 0.6667, 0.5, 0.5, 0.5, 0.5, ...
    0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.5, 0.431, 0.258, 1.0, 0.5, ...
    1.0, 0.125, 0.125, 0.125, 0, 0, 0, 0.1, 0.12, 0.12, 0.12, 0.1];


% Load Document Into Array
Doc = regexp(fileread([File_Location 'output.out']),'\n','split');
% In array, find the results of the multiple starts
LineNum = find(contains(Doc,'<<<<< Results summary:'));

hd = strsplit(cell2mat(Doc(LineNum+1)));

for msit = 1:MltStrts
    offset = 1 + msit;  
    vals = strsplit(cell2mat(Doc(LineNum+offset)));
    
    PrmVal_Int(msit,:) = cellfun(@str2num,vals(3:53));
    PrmVal_Fnl(msit,:) = cellfun(@str2num,vals(54:104));
    
    ObjVal(msit) = str2num(cell2mat(vals(105)));
    
end

clear Doc

[ObjVal_Srt, MS_Srt] = sort(ObjVal,'ascend');

%%
close all
PrmAxisLabels = Parameter_Labels;
for i = 2:2:51
    PrmAxisLabels{i} = ['- - - ' Parameter_Labels{i}];
end

f1 = figure(1); f1.Color = FigClr; f1.InvertHardcopy = 'off';
scatter([1:51],PrmVal_Fnl(MS_Srt(1),:)-PrmVal_Ref,'filled')

yl = ylabel({'Difference in Normalized Parameter Value';'$p_{i} - p_{o}$'});


ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times'; ax.TickLabelInterpreter = 'latex';

set(gca,'xtick',[1:51],'Xticklabel',PrmAxisLabels,'xticklabelrotation',270);

ln = line([0 52], [0 0]); ln.Color = 'k';
xlim([0 52]), ylim([-1 1])


% Reordering the final result plot with respect to most sensitive
% parameters
Temp = load('ParameterIndexOrder.mat'); 
Index = Temp.Prm_Ind_Srt2;

for i = 1:length(Index)
    Parameter_Labels_Ord{i} = Parameter_Labels{Index(i)};
	
    PrmVal_Ref_Ord(i) = PrmVal_Ref(Index(i));
    
    PrmVal_Int_Ord(:,i) = PrmVal_Int(:,Index(i));
    PrmVal_Fnl_Ord(:,i) = PrmVal_Fnl(:,Index(i));
end

% % Best Solution with Ranked Parameter Responses
PrmAxisLabels_Ord = Parameter_Labels_Ord;
for i = 2:2:51
    PrmAxisLabels_Ord{i} = ['- - - ' Parameter_Labels_Ord{i}];
end

f2 = figure(2); f2.Color = FigClr; f2.InvertHardcopy = 'off'; 
scatter([1:51],PrmVal_Int_Ord(MS_Srt(1),:)-PrmVal_Ref_Ord,'filled'), hold on
scatter([1:51],PrmVal_Fnl_Ord(MS_Srt(1),:)-PrmVal_Ref_Ord,'filled')
for prm = 1:51
    line([prm prm], [PrmVal_Int_Ord(MS_Srt(1),prm) PrmVal_Fnl_Ord(MS_Srt(1),prm)] - PrmVal_Ref_Ord(prm))
end

yl = ylabel({'Difference in Normalized Parameter Value';'$p_{i} - p_{o}$'}); 

ax = gca;
ax.Color = FigClr; ax.XColor = AxsClr; ax.YColor = AxsClr;
ax.Box = 'on'; ax.FontName = 'Times'; ax.TickLabelInterpreter = 'latex';

set(gca,'xtick',[1:51],'Xticklabel',PrmAxisLabels_Ord,'xticklabelrotation',270);

ln = line([0 52], [0 0]); ln.Color = 'k';
xlim([0 52]), ylim([-1 1])

ld = legend('Initial','Final');

% % All Multistart Cases
f3 = figure(3); f3.Color = FigClr; f3.InvertHardcopy = 'off'; 
for splt = 1:MltStrts
    subplot(1,MltStrts,splt)
    hold on
    scatter([1:51],PrmVal_Int_Ord(splt,:)-PrmVal_Ref_Ord,'filled')
    scatter([1:51],PrmVal_Fnl_Ord(splt,:)-PrmVal_Ref_Ord,'filled')
    % scatter([1:length(prmtrs)],PrmVal_Ref,'filled')
    for prm = 1:51
        line([prm prm], [PrmVal_Int_Ord(splt,prm) PrmVal_Fnl_Ord(splt,prm)] - PrmVal_Ref_Ord(prm))
    end
    
    ttl = title(['Multistart ' num2str(splt)]);
    xl = xlabel('Sensitvity Ranking');
    ln = line([0 52], [0 0]); ln.Color = 'k';
    xlim([0 52]), ylim([-1 1])
    
    if splt == 1; 
        yl = ylabel({'Difference from Nominal Value';'Normalized Values'});
    elseif splt == MltStrts
        ld = legend('Initial','Final');
    end
end


