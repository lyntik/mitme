function f = cost(X)

% sdd = 442.74 + X(1);
% source_x = 0 + X(2);
% proj_x = 0.396 + X(3);
sdd = 442.74;
source_x = 0;
proj_x = 0.396 + X(1);
cmd = sprintf('rtksimulatedgeometry -o geometry.xml --n 180 --arc=360 --sdd=%.3f --sid=41.24 --source_x=%.6f --proj_iso_y=-33.3135 --proj_iso_x=%.6f', sdd, source_x, proj_x);
system(cmd);
cmd = 'rtkfdk --hardware=cuda -l -p /home/fna/scans/test15/3/CCW/tifs2 -r [0-9]+.tif$ -o slice.mha -g geometry.xml --verbose --dimension 1472,1,1472 --spacing 0.009221575 --newspacing 0.099 --neworigin -145.728,-56.9745,0 --subsetsize=8';
system(cmd);

[raw] = loadMetaImage('/home/fna/dev/mitme/slice.mha');
slice = raw;

% /home/fna/scans/test14, /home/fna/scans/test14/noch
% profileX1 = slice(114, 600:900);
% profileY1 = slice(20:270, 715);
% profileX2 = slice(906, 1250:1450);
% profileY2 = slice(800:1000, 1392);
% profileX3 = slice(1359, 400:550);
% profileY3 = slice(1250:1400, 496);    
% profileX4 = slice(781, 60:200);
% profileY4 = slice(684:830, 131);    

% /home/fna/scans/test14/long
% profileX1 = slice(114, 600:900);
% profileY1 = slice(20:270, 736);
% profileX2 = slice(928, 1250:1450);
% profileY2 = slice(800:1000, 1392);
% profileX3 = slice(1350, 400:550);
% profileY3 = slice(1250:1400, 476);    
% profileX4 = slice(756, 60:200);
% profileY4 = slice(684:830, 131);    

profileX1 = slice(121, 717:800);
profileX2 = slice(917, 1320:1378);
profileY3 = slice(1310:1357, 469);    
profileX4 = slice(770, 113:170);


% 
% f = max(gradient(profileX1));
% f = f + max(gradient(profileY1));
% f = f + max(gradient(profileX2));
% f = f + max(gradient(profileY2));
% f = f + max(gradient(profileX3));
% f = f + max(gradient(profileY3));
% f = f + max(gradient(profileX4));
% f = f + max(gradient(profileY4));
%     


% f = max(gradient(profileX1));
% f = min(f, max(gradient(profileY1)));
% f = min(f, max(gradient(profileX2)));
% f = min(f, max(gradient(profileY2)));
% f = min(f, max(gradient(profileX3)));
% f = min(f, max(gradient(profileY3)));
% f = min(f, max(gradient(profileX4)));
% f = min(f, max(gradient(profileY4)));


f = max(gradient(profileX1));
f = min(f, max(gradient(profileX2)));
f = min(f, max(gradient(profileY3)));
f = min(f, max(gradient(profileX4)));
    

    
 f = double(-1 * f);

X
f
