
figure('Renderer', 'painters', 'Position', [10 10 400 300]);
set(0,'defaultAxesFontSize',12)

syms x;
a =      0.93464;
b =      -3.934;
c =      -651.4;
t =       -1022;
f(x) = a*x+b-c/(x-t);
plot(0:150, f(0:1:150), '.-b', 'DisplayName', '1 cluster'); hold on;

a =       1.031;
b =      -4.336;
c =      -163.4;
t =      -679.5;
f(x) = a*x+b-c/(x-t);
plot(0:150, f(0:1:150), '.-r', 'DisplayName', '2 cluster'); hold on;

a =           1;
b =     -0.4772;
c =       101.4;
t =       11.14;
f(x) = a*x+b-c/(x-t);
plot(18:150, f(18:1:150), '.-k', 'DisplayName', '3 cluster'); hold on;


xlabel('Energy, keV');
ylabel('TOT');
legend('show', 'Location','northwest');
print('-clipboard','-dbitmap');


%% 
% cluster 1

figure('Renderer', 'painters', 'Position', [10 10 900 720]);

e = [   49.3 37.04 26.47  24.65  18.52  12.38  ];
mean = [ 42    31    22     20     14    8  ];
plot(e, mean, '.-b', 'DisplayName', 'XRD'); hold on;
e = [ 8    11  22   25    28  43   ];
mean = [ 5  8  19   22    24  37 ];
plot(e, mean, '.-r', 'DisplayName', 'XRF'); hold on;
e = [  53 59.54  81  122  ];
mean = [ 46 53  81 122 ];
plot(e, mean, '.-g', 'DisplayName', 'sources'); hold on;

xlabel('TOT');
ylabel('Energy, keV');
title('TOT vs Energy dependency (calibration curve) 1 cluster');
legend('show');
print('-clipboard','-dbitmap');


e = [      59.54   53   49.3 37.04 26.47  24.65  18.52  12.38  ];
mean = [   53    46    42    31    22     20     14    8  ];
%      f(x) = a*x+b-c/(x-t)
% Coefficients (with 95% confidence bounds):
%        a =      0.9346  (-293.6, 295.4)
%        b =      -3.934  (-6.33e+05, 6.33e+05)
%        c =      -651.4  (-9.87e+08, 9.87e+08)
%        t =       -1022  (-5.337e+08, 5.337e+08)
%%%% my fit error: ~0.7 keV

%%
% cluster 2

figure('Renderer', 'painters', 'Position', [10 10 400 300]);
set(0,'defaultAxesFontSize',12)

%figure('Renderer', 'painters', 'Position', [10 10 900 720]);

e = [   56.98   52.94     49.3 37.04 26.47  24.65  18.52  ];
mean = [ 54       49.5     46    34    24     22     15    ];
plot(e, mean, '.-b', 'DisplayName', 'XRD'); hold on;
e = [     11   22   25   43  59.3  74.9];
mean = [  8    20   23   40   57   72 ];
plot(e, mean, '.-r', 'DisplayName', 'XRF'); hold on;
e = [ 33   59.54  67.87  81  122];
mean = [ 30  57    66     80 122];
plot(e, mean, '.-g', 'DisplayName', 'sources'); hold on;

xlabel('Energy, keV');
ylabel('TOT');
%title('TOT vs Energy dependency (calibration curve) 2 cluster');
legend('show');
print('-clipboard','-dbitmap');

e = [  122  81   67.87    56.98   52.94     49.3 37.04 26.47  24.65  18.52  ];
mean = [ 122   80   66   54       49.5     46    34    24     22     15    ];
%      f(x) = a*x+b-c/(x-t)
% Coefficients (with 95% confidence bounds):
%        a =       1.031  (-13.68, 15.75)
%        b =      -4.336  (-2.299e+04, 2.298e+04)
%        c =      -163.4  (-2.462e+07, 2.462e+07)
%        t =      -679.5  (-3.744e+07, 3.744e+07)
%%%% my fit error: 1 keV

%%
% cluster 3

figure('Renderer', 'painters', 'Position', [10 10 900 720]);

e = [     79.41  56.98   52.94     49.3 37.04   28.49  26.47  24.65  ];
mean = [   77     55       50     46    32.8     22    19      17    ];
plot(e, mean, '.-b', 'DisplayName', 'XRD'); hold on;
e = [    22  25     28   43  59.3 74]; 
mean = [   15  18     23   40 58 74 ]; 
plot(e, mean, '.-r', 'DisplayName', 'XRF'); hold on;
e = [    53 68  78 81 ]; 
mean = [ 53  68  78 81 ]; 
plot(e, mean, '.-g', 'DisplayName', 'sources'); hold on;

xlabel('TOT');
ylabel('Energy, keV');
title('TOT vs Energy dependency (calibration curve) 3 cluster');
legend('show');
print('-clipboard','-dbitmap');

e = [     79.41  56.98   52.94     49.3 37.04   28.49  26.47  24.65  ];
mean = [   77     55       50     46    32.8     22    19      17    ];
%        a =           1  (fixed at bound)
%        b =     -0.4772  (-2.864, 1.91)
%        c =       101.4  (-30.02, 232.8)
%        t =       11.14  (-3.29, 25.58)

%%%% my fit error: 0.5 keV





