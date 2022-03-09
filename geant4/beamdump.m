

figure(1);

k = 1;

% I
q = 1.6*10^-19;
N = 50000000;
t = 1;
I = N*q/t;
Ireal = 10^-3;
k = k * Ireal/I;

% spatial
[x, y] = loadXY('/opt/data/W_100keV_30deg_5E7.txt');
r1 = [-2.1737 -3.765 2.1737];
r2 = [-2.1737 -3.765 -2.1737];
r3 = [2.1737 -3.765 -2.1737];
r4 = [125 -3.765 125];

k = k * 4*pi/solidAngleTriangle(r1, r2, r3);
y = k.*y;
eventsTube =  sum(y); % 4pi, second

% exp, beamdump hole

r1 = [-2.5 -180.2 1.956];
r2 = [-2.5 -180.2 -1.956];
r3 = [2.5 -180.2 -1.956];
k = 4*pi/solidAngleTriangle(r1, r2, r3);
%
plot(x, y./k, '.-b', 'DisplayName', 'W spectrum'); hold on; title('W spectrum'); xlabel('Eneregy, keV'); ylabel('Counts, N');  print('-clipboard','-dbitmap');
saveXY('beamdump-inc.txt', 'e', 'c', x, y./k);
% exp
events = 101500000;
eventsExp = k*events;

seconds = eventsExp/eventsTube

return;

figure(2);

[x, y] = loadXY('/home/fna/dev/geant4/beamdump/build/out/without.txt');
y1 = y;
plot(x, 1/seconds.*y, '.-r', 'DisplayName', 'without upper plate'); hold on;
saveXY('beamdump-without.txt', 'e', 'c', x, 1/seconds.*y);

[x, y] = loadXY('/home/fna/dev/geant4/beamdump/build/out/with.txt');
y2 = y;
plot(x, 1/seconds.*y, '.-b', 'DisplayName', 'with upper plate'); hold on;
saveXY('beamdump-with.txt', 'e', 'c', x, 1/seconds.*y);

title(''); xlabel('Eneregy, keV'); ylabel('Counts, N');  print('-clipboard','-dbitmap');

legend('show');

%100000000LL

return;