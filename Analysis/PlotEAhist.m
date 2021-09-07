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

 % % TRYING TO FIGURE OUT HOW TO VIEW THE RESULTS FROM THE EA RESULTS % %

% Case Directory
% =-=-=-=-=-=-= %
Dir = '../PE-Runs/05Prm-OSSE-1D-EAwNorm/';

% Opt Directory 
ObjDr = 'opt_dir/PEOutput.dat';

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

% for i = 1:num_prm
%     prm_hist(i,:) = histcounts(prm_val(:,i),[0:0.01:1.0]);
% end
% 
% obj_mx = max(obj_val);
% obj_mn = min(obj_val);
% dobj = (obj_mx - obj_mn) / 1000
% obj_hist = histcounts(obj_val,[obj_mn:dobj:obj_mx]);
% sum(obj_hist)
% 
% figure()
% for i = 1:num_prm
%     subplot(1,num_prm,i)
%     bar(prm_hist(i,:))
% end 
% 
% figure()
% bar(obj_hist)% /sum(obj_hist)

figure()

% Row 1
subplot(5,5,1)
% scatter(prm_val(:,1),prm_val(:,1),[],obj_val,'filled')
scatter(prm_val(:,1),obj_val,[10],obj_val,'filled')
ylabel('p_{PAR}')

subplot(5,5,2)
scatter(prm_val(:,2),prm_val(:,1),[10],obj_val,'filled')

subplot(5,5,3)
scatter(prm_val(:,3),prm_val(:,1),[10],obj_val,'filled')

subplot(5,5,4)
scatter(prm_val(:,4),prm_val(:,1),[10],obj_val,'filled')

subplot(5,5,5)
scatter(prm_val(:,5),prm_val(:,1),[10],obj_val,'filled')

% Row 2
subplot(5,5,6)
scatter(prm_val(:,1),prm_val(:,2),[10],obj_val,'filled')
ylabel('p_{eps0}')

subplot(5,5,7)
%scatter(prm_val(:,2),prm_val(:,2),[],obj_val,'filled')
scatter(prm_val(:,2),obj_val,[10],obj_val,'filled')

subplot(5,5,8)
scatter(prm_val(:,3),prm_val(:,2),[10],obj_val,'filled')

subplot(5,5,9)
scatter(prm_val(:,4),prm_val(:,2),[10],obj_val,'filled')

subplot(5,5,10)
scatter(prm_val(:,5),prm_val(:,2),[10],obj_val,'filled')

% Row 3
subplot(5,5,11)
scatter(prm_val(:,1),prm_val(:,3),[10],obj_val,'filled')
ylabel('p_{sum}')

subplot(5,5,12)
scatter(prm_val(:,2),prm_val(:,3),[10],obj_val,'filled')

subplot(5,5,13)
%scatter(prm_val(:,3),prm_val(:,3),[],obj_val,'filled')
scatter(prm_val(:,3),obj_val,[10],obj_val,'filled')

subplot(5,5,14)
scatter(prm_val(:,4),prm_val(:,3),[10],obj_val,'filled')

subplot(5,5,15)
scatter(prm_val(:,5),prm_val(:,3),[10],obj_val,'filled')

% Row 4
subplot(5,5,16)
scatter(prm_val(:,1),prm_val(:,4),[10],obj_val,'filled')
ylabel('z_{sum}')

subplot(5,5,17)
scatter(prm_val(:,2),prm_val(:,4),[10],obj_val,'filled')

subplot(5,5,18)
scatter(prm_val(:,3),prm_val(:,4),[10],obj_val,'filled')

subplot(5,5,19)
%scatter(prm_val(:,4),prm_val(:,4),[],obj_val,'filled')
scatter(prm_val(:,4),obj_val,[10],obj_val,'filled')

subplot(5,5,20)
scatter(prm_val(:,5),prm_val(:,4),[10],obj_val,'filled')

% Row 5
subplot(5,5,21)
scatter(prm_val(:,1),prm_val(:,5),[10],obj_val,'filled')
xlabel('p_{PAR}'), ylabel('z_{paPPY}')

subplot(5,5,22)
scatter(prm_val(:,2),prm_val(:,5),[10],obj_val,'filled')
xlabel('p_{eps0}')

subplot(5,5,23)
scatter(prm_val(:,3),prm_val(:,5),[10],obj_val,'filled')
xlabel('p_{sum}')

subplot(5,5,24)
scatter(prm_val(:,4),prm_val(:,5),[10],obj_val,'filled')
xlabel('z_{sum}')

subplot(5,5,25)
% scatter(prm_val(:,5),prm_val(:,5),[],obj_val,'filled')
scatter(prm_val(:,5),obj_val,[10],obj_val,'filled')
xlabel('z_{paPPY}')
