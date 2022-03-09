function [y] = loadMCA(filepath)
filepath

fileID = fopen(filepath)
data = fread(fileID, '*char');

pos1 = strfind(data', '<<DATA>>');
pos2 = strfind(data', '<<END>>');

y = data(pos1+10:pos2-3)';
y = strsplit(y, '\n');
y = str2num(char(y));


fclose(fileID);

