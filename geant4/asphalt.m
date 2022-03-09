
% figure('rend', 'painters', 'pos', [500 500 1100 800]);
% subplot(2,1,1);
% suptitle({'', 'ag 20 degress xray spectra'}); 
% 
% [x, y] = loadXY('/home/fna/dev/geant4/asphalt/build/out/ag-tube-spectrum-50.txt');
% plot(x/10, y, '.-b', 'DisplayName', '50 keV'); hold on;
% [x, y] = loadXY('/home/fna/dev/geant4/asphalt/build/out/ag-tube-spectrum-60.txt');
% plot(x/10, y/6.5, '.-r', 'DisplayName', '60 keV'); hold on;
% title('linear'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');

% subplot(2,1,2);
% [x, y] = loadXY('/home/fna/dev/geant4/asphalt/build/out/ag-tube-spectrum-50.txt');
% plot(x/10, log10(y), '.-b', 'DisplayName', '50 keV'); hold on;
% [x, y] = loadXY('/home/fna/dev/geant4/asphalt/build/out/ag-tube-spectrum-60.txt');
% plot(x/10, log10(y/6.5), '.-r', 'DisplayName', '60 keV'); hold on;
% title('log10'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');

%return;

% 30000000 events processed
[x, y] = loadXY('/home/fna/dev/geant4/asphalt/build/out/tube-spectrum.txt');

%  [x, y] = loadXY('/home/fna/dev/geant4/asphalt/build/out/inc/12-0/10_11.txt');
%  sum(y)


%plot(x, y, '.-r');

k = 1;

% I
q = 1.6*10^-19;
N = 30000000;
t = 1;
I = N*q/t;
Ireal = 10^-3;
k = k * Ireal/I;

% spatial
k = k * 6;

% seconds
events = 8000000000;
%events = 10^10;
seconds = events/sum(k.*y)

%plot(x, k.*y, '.-b');

% mass
%p = 7.1;
p = 1;
thick = 6;
m = thick * 50 * 50 * 10^-3 * p / 1000; % in kg

% grey - Joule / kg per hour
grey = 10^3 * 1.6021766209 * 10^-19 / m *     3600 / seconds;

% 
% 

samplesNumberXFront = 25;
samplesNumberYFront = 14;
samplesNumberXProfile = 50;
samplesNumberYProfile = 14;
samplesNumberXTop = 25;
samplesNumberYTop = 50;

figure(1);
colormap jet; md = matrixDose('/home/fna/dev/geant4/asphalt/build/out/deposit/12-0', 0, samplesNumberXFront-1, 0, samplesNumberYFront-1); imagesc(flip(md,1).*grey); truesize([size(md,1)*40 size(md,2)*40]); title(sprintf('avg %.6f ugrey', sum(sum(md))/numel(md)*grey*1000000)); colorbar;
figure(2);
colormap jet; md = matrixDose('/home/fna/dev/geant4/asphalt/build/out/deposit/12-1', 0, samplesNumberXFront-1, 0, samplesNumberYFront-1); imagesc(flip(md,1).*grey); truesize([size(md,1)*40 size(md,2)*40]); title(sprintf('avg %.6f ugrey', sum(sum(md))/numel(md)*grey*1000000)); colorbar;
figure(3);
colormap jet; md = matrixDose('/home/fna/dev/geant4/asphalt/build/out/deposit/34-1', 0, samplesNumberXProfile-1, 0, samplesNumberYProfile-1); imagesc(flip(md,1).*grey); truesize([size(md,1)*40 size(md,2)*40]); title(sprintf('avg %.6f ugrey', sum(sum(md))/numel(md)*grey*1000000)); colorbar;

md = matrixDose('/home/fna/dev/geant4/asphalt/build/out/deposit/5-0', 0, samplesNumberXTop-1, 0, samplesNumberYTop-1);
md = flip(md,1);
md = md(1:20, 1:10);
avgForROI = sum(sum(md))/numel(md)*grey*1000000;
figure(4);
colormap jet; md = matrixDose('/home/fna/dev/geant4/asphalt/build/out/deposit/5-0', 0, samplesNumberXTop-1, 0, samplesNumberYTop-1); imagesc(flip(md,1).*grey); truesize([size(md,1)*40 size(md,2)*40]); title(sprintf('avg %.6f ugrey; avg for ROI(1:20, 1:10) %.6f ugrey', sum(sum(md))/numel(md)*grey*1000000, avgForROI)); colorbar;





%md = matrixDose('/home/fna/dev/geant4/asphalt/build/out/inc/34-1', 0, 19, 0, 13); imagesc(md); colormap jet; colorbar;
%md = matrixDose('/home/fna/dev/geant4/asphalt/build/out/inc/5-0', 0, 19, 0, 21); imagesc(md); colormap jet; colorbar;


