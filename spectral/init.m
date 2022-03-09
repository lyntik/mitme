global MEASUREMENT_DATA_PATH;
%MEASUREMENT_DATA_PATH = '//192.168.0.105/work/politeh/thrscan/bias200clock16';
MEASUREMENT_DATA_PATH = 'c:/work/acquisition/orig/bias200clock16';


global colors;
colors = {'.-b', '.-g' '.-r' '.-k' '.-c' '.-m' '.-y' };

warning('off', 'stats:dataset:ModifiedVarnames');


%codegen('spectral/calc_thicknesses.m','-args',{inc, M, ATT, [10], Rij})

