


%metaInitial = [0.5689   -0.0092    0.1345]; % /home/fna/scans/test14 -28.15
%metaInitial = [-0.0018   -0.0004   -0.0007]; % /home/fna/scans/test14/noch -27.5227
%metaInitial = [-0.2992   -0.0002   -0.0116]; % /home/fna/scans/test14/long  -28.6125

% /home/fna/scans/test14 only X -3.0836: 0.0669
% /home/fna/scans/test14 all -3.1203: -0.7262    0.0114   -0.0601

% /home/fna/scans/test14/noch only X -3.1247:  0.0057
% /home/fna/scans/test14/noch all -3.0966: -0.2148   -0.0007    0.0226

%  /home/fna/scans/test14/long only X -3.1817: 0.0068
%  /home/fna/scans/test14/long only X -3.1716:  -0.1317    0.0003    0.0063

metaInitial = [0] ;


A = [];
b = [];
Aeq = [];
beq = [];
nonlcon = [];

% lb = [ -3; -0.1; -0.3;  ];
% ub = [ 3; 0.1; 0.3;  ];
lb = [ -0.3;];
ub = [ 0.3; ];


[X, fval, exitflag] = fmincon(@cost, double(metaInitial), A, b, Aeq, beq, lb, ub, nonlcon, optimset('MaxFunEvals', 100, 'MaxIter', 100,  'Display', 'None', 'Algorithm', 'active-set', 'DiffMinChange', 0.001, 'DiffMaxChange', 1 ) );
%'TolX', 0.00001,
%[X, fval, exitflag] = fmincon(@cost, double(metaInitial), A, b, Aeq, beq, lb, ub, nonlcon, optimset('MaxFunEvals',10000000, 'MaxIter', 100000, 'TolX', 1, 'Display', 'None', 'Algorithm', 'sqp' ) );
fval
X
return;

%.
% A = [];
% b = [];
% Aeq = [];
% beq = [];
% nonlcon = [];
%.
% lb = [ 15; 30; 50;  ];
% ub = [ 20; 40; 70;  ];
% % lb = zeros(2, 1);
% % ub = zeros(2, 1);
% % for i = 1:size(ub, 1)
% %     lb(i) = 0;
% %     ub(i) = 5;
% % end

[meta, fval, exitflag] = fminsearch(@cost, double(metaInitial), optimset('MaxFunEvals', 10000000, 'MaxIter', 300, 'TolX', 0.0001, 'Display', 'none') );

meta

return;

figure(2);

sdd = 442.74;
source_x = 0;
proj_x = 1.287;
cmd = sprintf('rtksimulatedgeometry -o geometry.x geometry.xml --n 180 --arc=360 --sdd=%.3f --sid=41.24 --source_x=%.6f --proj_iso_y=-33.3135 --proj_iso_x=%.6f', sdd, source_x, proj_x);
system(cmd);
cmd = 'rtkfdk --hardware=cuda -p /home/fna/scans/test15/4/left/CCW -r [0-9]+.tif$ -o slice.mha -g geometry.xml --verbose --dimension 1472,1,1472 --spacing 0.009221575 --newspacing 0.099 --neworigin -145.6785,-56.9745,0 --subsetsize=8';
system(cmd);

return;



[raw] = loadMetaImage('/home/fna/dev/mitme/slice.mha');
[raw] = loadMetaImage('/home/fna/scans/test14/long/V/slice.mha');


imagesc(raw(:, :, 1));

figure(2);
%imagesc(raw(:, :, 212));

%slices = 212+(-50:50);
slices = 1;

gradsX1 = zeros(numel(slices), 1);
gradsY1 = zeros(numel(slices), 1);
gradsX2 = zeros(numel(slices), 1);
gradsY2 = zeros(numel(slices), 1);
gradsX3 = zeros(numel(slices), 1);
gradsY3 = zeros(numel(slices), 1);
gradsX4 = zeros(numel(slices), 1);
gradsY4 = zeros(numel(slices), 1);

i = 1;
for s=slices
    slice = raw(:, :, s);

    profileX1 = slice(114, 600:900);
    profileY1 = slice(20:270, 715);
    profileX2 = slice(906, 1250:1450);
    profileY2 = slice(800:1000, 1392);
    profileX3 = slice(1359, 400:550);
    profileY3 = slice(1250:1400, 496);    
    profileX4 = slice(781, 60:200);
    profileY4 = slice(684:830, 131);    
    
    gradsX1(i) = max(gradient(profileX1));
    gradsY1(i) = max(gradient(profileY1));
    gradsX2(i) = max(gradient(profileX2));
    gradsY2(i) = max(gradient(profileY2));
    gradsX3(i) = max(gradient(profileX3));
    gradsY3(i) = max(gradient(profileY3));
    gradsX4(i) = max(gradient(profileX4));
    gradsY4(i) = max(gradient(profileY4));
    
    i = i + 1;
end    

%plot(1:numel(profile), profileY, '.-b');
%plot(1:numel(profile), profileY, '.-b');
%plot(1:numel(profile), gradient(profile), '.-b');

plot(slices, gradsX1, '.-b'); hold on;
plot(slices, gradsY1, '.-r'); hold on;
plot(slices, gradsX4, '.-k'); hold on;
plot(slices, gradsY4, '.-g'); hold on;


