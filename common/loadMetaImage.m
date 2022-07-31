function [raw] = loadMetaImage(filepath)

fileID = fopen(filepath);
header = fread(fileID, [1, 1000], '*char')

pos = strfind(header,'DimSize');
dim = sscanf(header(pos:end),'DimSize = %d %d %d');

pos = strfind(header,'ElementType');
elementType = sscanf(header(pos:end),'ElementType = %s')
if (strcmp(elementType, 'MET_USHORT') == 1) 
    elementType = '*ushort';
elseif (strcmp(elementType, 'MET_FLOAT') == 1) 
    elementType = '*single';
else
    error('ElementType is not supported.')
end
 
pos = strfind(header,'ElementDataFile');
dataFile = sscanf(header(pos:end),'ElementDataFile = %s')

if (strcmp(dataFile, 'LOCAL') == 1)
    fseek(fileID, pos+24-1, 'bof');
else
    fclose(fileID);
    fileID = fopen(strcat(fileparts(filepath), '/', dataFile));
end

raw = fread(fileID, prod(dim),  elementType);
fclose(fileID);


% 
raw = reshape(raw, dim');
% raw = permute(raw, [3, 1, 2]);
% 
% raw = flip(raw, 1);



