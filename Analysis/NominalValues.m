close all, clear all, clc

FileIn = 'Values.txt';

fid = fopen(FileIn,'r');
Data = fscanf(fid,'%f %f %f',[3 51]);
fclose(fid);

Data = Data';

NV = ( Data(:,1) - Data(:,2) ) ./ ( Data(:,3) - Data(:,2) )
