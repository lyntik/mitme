
% stage 1
% e- 352000000

ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/inc.txt'));
dd = double(ds);
inc = dd(:, 2);

r1 = [-50 -50 3];
r2 = [-50 -50 -97];
r3 = [50 -50 -97];
r4 = [50 -50 3];
w_gather = solidAngleTriangle(r1, r2, r3) + solidAngleTriangle(r3, r4, r1);


emission = 352000000; % e-
I = emission * 1.6 * 10^-19;

Nph = sum(inc);
diffracted_bin =  inc(6);


% stage 2
% gamma - 992000000
%

H = 1;
R = 0.0349;
w_real = 2 * pi * (1 - H / sqrt(R^2 + H^2));

Nph2 = Nph * (w_real/w_gather);
diffracted_bin2 = diffracted_bin * (w_real/w_gather);

emission = 992000000; % gamma
I2 = (emission / Nph2) * I
diffracted_bin2 = (emission / Nph2) * diffracted_bin2;

incnorm = (w_real/w_gather) * emission / Nph2;

% ---

ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/scatter1.txt'));
dd = double(ds);
scatter1 = dd(:, 2);

%
% energy - 6.45 kEv
% detector crop (reflex line): 
% Y proportion is: on 1:0.0349, so 10+20 = 300*0.0349=10.47 mm
% X: reflex_geom_part(6.45, 200, 1)
w_gather = solidAngleIdealGeomDetectorSource(50*2, 50*2, 200);
w_real = solidAngleIdealGeomDetectorSource(30.9494, 10.47, 200);

Nscatter = (w_real / w_gather) * sum(scatter1);

SNR1 = (0.5 * diffracted_bin2) / Nscatter

scatter1norm = (w_real/w_gather);


% stage 3
% gamma - 15720000000
ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/scatter2.txt'));
dd = double(ds);
scatter2 = dd(:, 2);


w_real = (50*2*20*2*cos(pi/4)) / 250^2;
Nscatter0 = (w_real / w_gather) * sum(scatter1);

% Y proportion is: on 1:0.0349, so 10+25+20 = 550*0.0349=19.195 mm
w_real = solidAngleIdealGeomDetectorSource(30.9494, 19.195, 200);

emission = 15720000000;

Nscatter = (w_real / w_gather) * (Nscatter0 / emission) * sum(scatter2);


% 10^-6 - its very conditional
SNR2 = (0.5 * 10^-6 * diffracted_bin2) / Nscatter

scatter2norm = (w_real/w_gather) * (Nscatter0 / emission);
% 
% ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/inc.txt'));
% dd = double(ds);
% sum(dd(1:100, 2))
% plot(0:1:99, log(dd(1:100, 2) .* incnorm), '.-b', 'DisplayName', 'incident'); hold on;
% 
% ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/scatter1.txt'));
% dd = double(ds);
% sum(dd(1:100, 2))
% plot(0:1:99, log(dd(1:100, 2) .* scatter1norm), '.-r', 'DisplayName', 'scatter1'); hold on;
% dd(1:100, 2) .* scatter1norm
% 
% ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/scatter2.txt'));
% dd = double(ds);
% sum(dd(1:100, 2))
% plot(0:1:99, log(dd(1:100, 2) .* scatter2norm), '.-k', 'DisplayName', 'scatter2'); hold on;
% 
% xlabel('Energy, kEv');
% ylabel('Intensity, N');
% title('Logarithmic scale of inc/scatter1/scatter2 spectra');
% legend('show');
% 
% return;

ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/inc_norm.txt'));
dd = double(ds);
sum(dd(1:100, 2))
plot(0:1:99, dd(1:100, 2), '.-b', 'DisplayName', 'incident'); hold on;

ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/scatter1_norm.txt'));
dd = double(ds);
sum(dd(1:100, 2))
plot(0:1:99, dd(1:100, 2), '.-r', 'DisplayName', 'scatter1'); hold on;

ds = dataset('File',sprintf('/home/fna/dev/tube_Ag_35_60_/build/scatter2_norm.txt'));
dd = double(ds);
sum(dd(1:100, 2))
plot(0:1:99, dd(1:100, 2), '.-k', 'DisplayName', 'scatter2'); hold on;


xlabel('Energy, kEv');
ylabel('Intensity, N');
title('inc/scatter1/scatter2 spectra');
legend('show');

    

