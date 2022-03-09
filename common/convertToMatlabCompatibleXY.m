function convertToMatlabCompatibleXY(fileFrom, fileTo, xlabel, ylabel)

fileID = fopen(fileFrom,'r');
A = fscanf(fileID,'      %f     %f',[2 Inf]);
fclose(fileID);

%return;

fileID = fopen(fileTo,'w');
fprintf(fileID, '%s\t%s\n', xlabel, ylabel);
for i = 1:size(A, 2)
    fprintf(fileID, '%.1f\t%.4f\n', A(1, i), A(2, i));
end
fclose(fileID);