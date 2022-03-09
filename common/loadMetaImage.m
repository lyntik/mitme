function [raw] = loadMetaImage(filepath)

% restictions:
% for LOCAL raw data (ElementDataFile = LOCAL)
% supported types: MET_FLOAT


fileID = fopen(filepath);
header = fread(fileID, [1, 1000], '*char');

pos = strfind(header,'DimSize');
dim = sscanf(header(pos:pos+100),'DimSize = %d %d %d');

%strfind(header,'ElementDataFile')
fseek(fileID, strfind(header,'ElementDataFile')+24-1, 'bof');

raw = fread(fileID, prod(dim),  '*single');
%raw = fread(fileID, prod(dim),  '*ushort');

raw = reshape(raw, dim');
raw = permute(raw, [3, 1, 2]);

raw = flip(raw, 1);


fclose(fileID);

