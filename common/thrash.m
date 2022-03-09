

%%% TODO: std, mean by one func. input: file, data?

[raw] = loadMetaImage('/home/fna/src2/RTK/build/bin/1/fdk.mha');
%piece = raw(55:65, 15:25, 3);
piece = raw(55:65, 55:65, 3);
piece = reshape(piece, [1, 121]);
mean(piece)
std(piece)