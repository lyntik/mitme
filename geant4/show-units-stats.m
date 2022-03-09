
fileID = fopen('/home/fna/dev/geant4/spectralct/build/stats');

%data = fread(fileID, '*char');

units(1) = "";
events(1) = double(0);


ind = 1;
tline = fgetl(fileID);
while ischar(tline)
    %disp(tline)
    units(ind) = tline;
    tline = fgetl(fileID);
    events(ind) = str2num(tline);
    tline = fgetl(fileID);
    ind = ind + 1;
end
fclose(fileID);

c = categorical(units);

% c = categorical({str('Ge (220)')
%     str('Si (400)')
%     str('Si (220)')});

bar(c, events);