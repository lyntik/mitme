
global DATA_PATH;
DATA_PATH = '/home/fna/data';

global XRAY_BASE_PATH;
XRAY_BASE_PATH = '/media/my2tb/xray-base';


global colors;
colors = {'.-b', '.-r', '.-k' '.-g' '.-c' '.-m' '.-y' };

warning('off', 'stats:dataset:ModifiedVarnames');

addpath('common');
addpath('common/reflex');
addpath('common/solid-angle');
addpath('common/dose');

addpath('TDI');
%addpath('geant4/ba_dose');

%addpath('medipix-characterization');

set(0,'defaultAxesFontSize',18)
set(0,'defaultAxesFontName','Times')
