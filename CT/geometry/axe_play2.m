
%%

figure(2);
path = '/home/fna/scans/test3/tube_4';
t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);
imagesc(img);

%%
% X
global colorIndex;

colorIndex = 1;
plotAxePlay('/home/fna/scans/test3/deg1_1', 360, 3, 2748, 136:146, 'x', "per", '1 deg 1 execution');
plotAxePlay('/home/fna/scans/test3/deg1_2', 360, 7, 2751, 136:146, 'x', "per", '1 deg 2th execution');
% legend('show');
% title('0-360 TEST. 1deg X');
% xlabel('Experiment number');
% ylabel('deviation (%)');

%colorIndex = 1;

plotAxePlay('/home/fna/scans/test3/deg0.2', 1800, 7, 2752, 136:146, 'x', "per", '0.2 deg 1 execution');
plotAxePlay('/home/fna/scans/test3/deg0.2_2', 1800, 7, 2752, 136:146, 'x', "per", '0.2 deg 2th execution');
% legend('show');
% title('0-360 TEST. X');
% xlabel('Experiment number');
% ylabel('deviation (%)');


plotAxePlay('/home/fna/scans/test3/deg0.1', 3600, 5, 2751, 136:146, 'x', "per", '0.1 deg 1 execution');
plotAxePlay('/home/fna/scans/test3/deg0.1_2', 3600, 7, 2751, 136:146, 'x', "per", '0.1 deg 2th execution');
legend('show');
title('0-360 TEST. X');
xlabel('Experiment number');plotAxePlay('/home/fna/scans/test3/deg360_5', 1, 7, 2747, 136:146, 'x', "per", '1 deg 1 execution');
ylabel('deviation (%)');

% colorIndex = 1;
% plotAxePlay('/home/fna/scans/test3/deg0.1', 3600, 5, 1523:1533, 54, 'y', "per", '1 execution');
% plotAxePlay('/home/fna/scans/test3/deg0.1_2', 3600, 5, 1523:1533, 54, 'y', "per", '1 execution');
% legend('show');
% title('0-360 TEST. 0.1deg Y');
% xlabel('Experiment number');
% ylabel('deviation (%)');

%%
% 0.2X speed
colorIndex = 1;
plotAxePlay('/home/fna/scans/test3/deg0.2', 1800, 7, 2752, 136:146, 'x', "per", '0.2 deg 1 execution');
plotAxePlay('/home/fna/scans/test3/deg0.2_2', 1800, 7, 2752, 136:146, 'x', "per", '0.2 deg 2th execution');

plotAxePlay('/home/fna/scans/test3/deg0.2_lowspeed', 1800, 7, 2752, 136:146, 'x', "per", '0.2 deg 1 execution low speed');
legend('show');
title('0-360 TEST. X');
xlabel('Experiment number');
ylabel('deviation (%)');


%%
% % 0.2Y

%plotAxePlay('/home/fna/scans/test3/deg0.2', 1800,eg0.2', 1800,
%plotAxePlay('/home/fna/scans/test3/deg0.2', 1800, 7, 1523:1533, 53, 'y', "value", '1 execution');
plotAxePlay('/home/fna/scans/test3/deg0.2_2', 1800, 7, 1523:1533, 52, 'y', "value", '2th execution');
legend('show');
title('0-360 TEST. Y');
xlabel('Experiment number');
ylabel('deviation (%)');

% % 0.2Y
%%%%%%%%%%%%% 
%% 360
% plotAxePlay('/home/fna/scans/test3/deg360', 1, 7, 2748, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_2', 1, 7, 2747, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_3', 1, 7, 2747, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_4', 1, 7, 2747, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_5', 1, 7, 2747, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_6', 1, 7, 2747, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_7', 1, 7, 2749, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_8', 1, 7, 2749, 136:146, 'x', "per", '1 deg 1 execution');
% plotAxePlay('/home/fna/scans/test3/deg360_9', 1, 7, 2749, 136:146, 'x', "per", '1 deg 1 execution');
%plotAxePlay('/home/fna/scans/test3/deg', 360, 7, 2759, 136:146, 'x', "perdiff", '1 deg 1 execution axe');
%plotAxePlay('/home/fna/scans/test3/deg1_2', 360, 7, 2759, 136:146, 'x', "perdiff", '1 deg 1 execution axe');

%% NEW 360 X

global colorIndex;
colorIndex = 1;
y = plotAxePlay('/home/fna/scans/test3/old/tube_2', 1, 480, 2757, 136:146, 'x', "per", 'tube drift', 220:480);
y = plotAxePlay('/home/fna/scans/test3/old/tube_3', 1, 106, 2758, 136:146, 'x', "per1", 'tube drift+axe', 50:106);
legend('show');
title('0-360 TEST. X, 360 deg, 30s');
xlabel('Experiment number');
ylabel('shadow movement (%)');


%% 360 Y
global colorIndex;
colorIndex = 1;
y = plotAxePlay('/home/fna/scans/test3/old/tube_2', 1, 480, 1300:1310, 52, 'y', "per", 'tube', 220:480);
y = plotAxePlay('/home/fna/scans/test3/old/tube_3', 1, 106, 1300:1310, 52, 'y', "per", 'tube+axe', 95:106);
legend('show');
title('0-360 TEST. X, 360 deg, 30s');
xlabel('Experiment number');
ylabel('shadow movement (%)');

%%
%% 360 exp2 X
global colorIndex;
colorIndex = 1;
y = plotAxePlay('/home/fna/scans/test3/tube', 1, 445, 2753, 136:146, 'x', "per", 'tube', 350:445);
y = plotAxePlay('/home/fna/scans/test3/tube_2', 1, 99, 2754, 140:150, 'x', "per", 'tube', 80:99);
%y = plotAxePlay('/home/fna/scans/test3/old/tube_3', 1, 106, 1300:1310, 52, 'y', "per", 'tube+axe', 95:106);
legend('show');
title('0-360 TEST. X, 360 deg, 30s');
xlabel('Experiment number');
ylabel('shadow movement (%)');


%% 1 X
global colorIndex;
colorIndex = 1;
y = plotAxePlay('/home/fna/scans/test3/tube_3', 360, 21, 2745, 136:146, 'x', "per", 'tube', 2:21);
y = plotAxePlay('/home/fna/scans/test3/tube_4', 360, 21, 2745, 136:146, 'x', "per", 'tube', 2:21);
legend('show');
title('0-360 TEST. X, 360 deg, 30s');
xlabel('Experiment number');
ylabel('shadow movement (%)');





