function [y] = loadASC(filepath)

fileID = fopen(filepath);
data = fread(fileID, '*char');
y = strsplit(data', '\n');
y = str2num(char(y));
y = y(:, 2);
