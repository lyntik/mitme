%% energy resolution
% x = [14.71  32.87 ];
% y = [5.64   4.91];
% x = [19.74  45.59];
% y = [6.003  4.935 ];
% 
% x = [22.95  49.15];
% y = [5.985  5.14 ];
% 
% 
% x = [53.58];
% y = [5.488 ];ction specifies the limits for the current axes.
% 
% x = [57.1];
% y = [5.345 ];
% 
% x = [79.42];
% y = [9.337 ];
% 
% x = [122.8];
% y = [10.19 ];
% 
%x = [32.87 45.59   49.15  53.58   57.1   79.42  122.8];
%y = [4.91  4.935  5.14    5.4     5.345  9.337  10.19];

figure('Renderer', 'painters', 'Position', [10 10 400 300]);
set(0,'defaultAxesFontSize',12)

x = [32.87 45.59   49.15  53.58      79.42  122.8];
y = [4.91  4.935  5.14    5.4       9.337  10.19];
y = sqrt(y);
plot(x, y./x*100, '.-b', 'DisplayName', '2 cluster'); hold on;


x = [ 49.65  54.13  58.25  80.31   121];
y = [ 5.349  5.437   5.712  7.5    11.29];
y = sqrt(y);
plot(x, y./x*100, '.-r', 'DisplayName', '3 cluster'); hold on;
% xlim([0 inf]);
% ylim([0 inf]);
%xlabel('TOT', 'FontSize', 8);
xlabel('Energy, keV');
ylabel('Resolution, %');
legend('show');
%stitle(sprintf('X-Ray Diffraction. Crystal Si 220. %d cluster', i));
print('-clipboard','-dbitmap');
