

% return;
% 
% ds = dataset('File', '/media/fna/SMBB/DESY_ALL/desy/measures/190724/direct_665.5.txt');
% %dd = double(ds);
% %x = dd(:,1);
% %y = dd(:,2); 
% 
% cellArray = cellstr(ds);
% str = char(cellArray(100));
% 
% C = char(strsplit(str,' '));
% 
% dd = zeros(256, 1);
% for i = 1:256
%     dd(i) = str2double(C(i, :));
% end
% 
% 
% x = 1:256;
% y = dd;
%     
% plot(1:256, dd, '.-b');
% 
% return;

% global colors;
% colorIndex = 1;
% 
% angles = {
%     '17.5'
%     '20'
%     };
% 
% figure(1);
% 
% for i=1:numel(angles)
%     
%     [x y] = loadXY(sprintf('/home/fna/data/timepix2/%s.txt', char(angles(i))));
%     x = x(1:500);
%     y = y(1:500);
%     plot(x, y, char(colors(colorIndex)), 'DisplayName', char(angles(i))); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end
%    
% end
% 
% legend('show');
% 
% return;
% 
% syms a;
% e(a) = 3.2291/sin(a*pi/180);
% 
% x = [double(e(20)) double(e(17.5)) double(e(15)) double(e(10)) double(e(4.5)) double(e(4))];
% y = [27 34 43 75 143 154];
% 
% a =     1.1;
% b =       170;
% c =   4330;
% t =      -18.6;
% syms x;
% f(x) = a*x+b-c/(x-t);
% g2 = finverse(f);

% 190724
%%% 1 exp
% 
% load('background.mat', 'fitresult' );
% f1 = fitresult;
% 
% files = { '/home/fna/data/DESY3_ALL/desy/measures/190724/py/pyro_1exp_6_2.txt'
%     %'/home/fna/data/DESY3_ALL/desy/measures/190725/py/pyro_1exp_7_2.txt'
%     '/home/fna/data/DESY3_ALL/desy/measures/190725/py/pyro_1exp_7.5_2.txt'
%     '/home/fna/data/DESY3_ALL/desy/measures/190726/py/pyro_6exp_8_no_filter_3gev_2.txt'
%     };
% 
% angles = { '6'
%     '7.5'
%     '8'
%     };
% 
% k = [1
%     1
%     1];
% 
% colorIndex = 1;
% for i=1:numel(files)
% 
%     [x y] = loadXY(char(files(i)));
%     x = x(1:280);
%     y = y(1:280);
%     y = y(1:280).*k(i);%-feval(fitresult, 1:300);
% %     
%     %x=x(47:74);
%     %y=y(47:74);
% 
% %     x=x(16:200);
% %     y=y(16:200);
%     
%     
%     %y(80:end) = 0;
%     
%     %y()
% %     
% %     y(y>17)=17;
% %      y(60:90) = Inf;
% %      y(1:13) = Inf;
%      %y(130:end) = Inf;
%     
% 
% %     x=x(1:34);
% %     y=sum(reshape(y, 3, 34));
% %     if (k(i) == 2)
% %         y(19)=17;
% %     end
%     %y(y<0)=0;
% 
%     plot(g2(1:2:280), sum(reshape(y-sub, [2 140])), char(colors(colorIndex)), 'DisplayName', sprintf('%s degrees', char(angles(i)))); hold on;
%     
%     %return;
%     
%     
% %     [xData, yData] = prepareCurveData( x, y );
% % 
% %     % Set up fittype and options.
% %     ft = fittype( 'gauss1' );
% %     opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% %     opts.Display = 'Off';
% %     opts.Lower = [-Inf -Inf 0];
%     %opts.StartPoint = [22.3276167242802 2 8.54636594437728];
% 
%     % Fit model to data.
% %     [fitresult, gof] = fit( xData, yData, ft, opts );
% %     
% %     
% %     syms xx;
% %     coeffs = coeffvalues(fitresult);
% %     if (i == 1)
% %         coeffs(3) = coeffs(3)*0.8;
% %     end
% %     if (i == 2)
% %         coeffs(1) = coeffs(1)*0.8;
% %         coeffs(3) = coeffs(3)*1.6;
% %     end
% %     f(xx) = coeffs(1)*exp(-(((xx-coeffs(2))/coeffs(3))).^2);
%     
%     %plot(g2(x*3), feval(fitresult, x), char(colors(colorIndex)), 'DisplayName', sprintf('%s degrees', char(angles(i)))); hold on;
%     %plot(g2(x*3), f(x), char(colors(colorIndex)), 'DisplayName', sprintf('%s degrees', char(angles(i)))); hold on;
%     
%     
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end    
%     
% %     title('6 degrees');
%     xlabel('Energy, keV');
%     ylabel('Intensity, N');
% 
%     ylim([0 45])
%     
%     %y(48:90) = inf;
%     
%     %return;
% end
% 
% legend('show');
% 
% return;

% % 190725
% 
% [x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190725/py/pyro_1exp_7_2.txt'));
% x = x(1:300);
% y = y(1:300);
% plot(g2(x), y.*2, '.-r', 'DisplayName', '7 degrees'); hold on;
% title('Pyro');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
% legend('show');
% 
% [x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190725/py/pyro_1exp_7.5_2.txt'));
% x = x(1:300);
% y = y(1:300);
% plot(g2(x), y, '.-k', 'DisplayName', '7.5 degrees'); hold on;
% title('');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
% legend('show');
% 
% 
% return;

% 6   17.56  (16.97, 18.16)
% 7 16  (15.62, 16.38)
% 7.5 14.64  (14.09, 15.19)
% 8 13.16 (12.87 13.46)

% angles = [6 7.5 8];
% 
% mean(1) = 17.56;
% mean(2) = 14.64;
% mean(3) = 13.16;
% 
% syms a;
% e(a) = 1.8562/sin(a*pi/180);
% 
% plot(angles, mean, '.-b', 'DisplayName', 'Experiment'); hold on;
% plot(angles, [e(6) e(7.5) e(8) ], '.-r', 'DisplayName', 'Bragg'); hold on;
% 
% 
% 
% plot(angles(1), mean(1), 'b*'); errorbar(angles(1), mean(1),(17.56-16.97)/2, 'b')
% plot(angles(2), mean(2), 'r*'); errorbar(angles(2), mean(2),(16-15.62)*1.1, 'b')
% plot(angles(3), mean(3), 'k*'); errorbar(angles(3), mean(3),(16-15.62), 'b')
% 
% 
% xlim([5.9 8.1])
% xticks([angles]);
% 
% legend('Experiment', 'Bragg');
% 
% xlabel('Angle, deg');
% ylabel('Energy, keV');


% %%% 2 exp
% with/without barrier
% magn
% [x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190725/py/pyro_1exp_7.5_2.txt'));
% x = x(1:280);
% y = y(1:280);
% plot(g2(1:2:280), sum(reshape(y, [2 140])), '.-b', 'DisplayName', 'without magn'); hold on;
% %plot(g2(x), y, '.-b', 'DisplayName', 'without barrier'); hold on;
% 
% plot(g2(1:2:280), sum(reshape(sub, [2 140])), '.-r', 'DisplayName', 'with magn'); hold on;
% 
% plot(g2(1:2:280), sum(reshape(y-sub, [2 140])), '.-k', 'DisplayName', 'substracted'); hold on;
% %plot(g2(x), y, '.-b', 'DisplayName', 'without barrier'); hold on;
% 
% ylim([0 40]);

% return;
%%% barrier
% [x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190725/py/pyro_2exp_7.5_2.txt'));
% x = x(1:280);
% y = y(1:280);
% plot(g2(1:2:280), sum(reshape(y, [2 140]))*1.6, '.-r', 'DisplayName', 'with barrier'); hold on;
% %plot(g2(x), y.*1.6, '.-r', 'DisplayName', 'without barrier'); hold on;


% title('Pyro 7.5 deg, magnet activation');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
% legend('show');
% 
% return;

% 190726

% % with/without filter
%[x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190726/py/pyro_6exp_8_no_filter_3gev_2.txt'));
% [x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190726/py/pyro_5exp_8_morecu_3gev_2.txt'));
% 
% x = x(1:280);
% y = y(1:280);%-feval(fitresult, 1:300);
% % 
% % y(25:75) = Inf;
% % y(1:25) = Inf;
% 
% % x=x(25:end);
% % y=y(25:end);
% 
% %y./160500
% plot(g2(1:2:280), sum(reshape(y./1-sub, [2 140])), '.-r', 'DisplayName', 'with filter'); hold on;
% title('Pyro 8 deg');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
% legend('show');
% ylim([0 60]);
% 
% return;

% intensity VS angle
% [x y] = loadXY(sprintf('/media/fna/SMBB/DESY_ALL/desy/measures/190726/py/pyro_5exp_8_morecu_3gev_2.txt'));
% x = x(1:300);
% y = y(1:300);
% plot(g2(x), y/165000, '.-r', 'DisplayName', '8 degrees'); hold on;
% title('Pyro 6, 8 degrees (intensity comparison)');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
% legend('show');

%save('3gev', 'fitresult');

% intensity VS energy
% a = 8.535e-05;
% b = 113;
% c = 26.83;
% syms xx;
% f(xx) = a*exp(-((xx-b)/c)^2)
% plot(1:300, double(f(1:300)), '.-b'); hold on;
% plot(x, y, '.-r'); hold on;
% plot(x, y-double(f(1:300))', '.-k'); hold on;
% 
%  return;

files = { '/home/fna/data/DESY3_ALL/desy/measures/190726/py/pyro_7exp_7_no_filter_1gev_2.txt'
    '/home/fna/data/DESY3_ALL/desy/measures/190726/py/pyro_7exp_7_no_filter_2gev_2.txt'
    '/home/fna/data/DESY3_ALL/desy/measures/190726/py/pyro_7exp_7_no_filter_3gev_2.txt' 
    };
norm = [ 349974 422318 343575 ];
magnnorm = [ 1.1 1.5 1.5 ];

colorIndex = 1;

integrals = zeros(3, 1);
for i=2:numel(files)
    
    [x y] = loadXY(char(files(i)));
    x = x(1:280);
    y = y(1:280);
    %y(1:83) = Inf;
    load(sprintf('%dgev', i));
    %y = y-sub.*magnnorm(i);
    
    %y = y./norm(i); %- double(f(1:300))';
    
    integrals(i) = sum(y(31:72));
    
    plot((x), y, char(colors(colorIndex)), 'DisplayName', sprintf('%d GeV', i)); hold on;
    title('Pyro 7 degrees, 1,2,3 GeV (intensity comparison)');
    xlabel('Energy, keV');
    ylabel('Intensity, N');
    legend('show');
    
    %return;
    
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end    
    
    break;
    
end

%ylim([0 15*10^-5]);

%plot((x), sub/norm(i).*magnnorm(i), '.-r'); hold on;
plot((x), sub, '.-r'); hold on;
% 
% % 
return;
% 
%  plot([1 2 3], [8.5280e-04 0.0019 0.0026], '.-b');
% plot([1 2 3], integrals, '.-b');
% xlabel('Beam Energy, geV');
% ylabel('Peak intensity, N');
% title('Pyro 7 degrees, Intensity VS Energy');
% xticks([1 2 3]);
% 
% 

% periodic target
figure(2);
[x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190726/py/pyro_8exp_7_perioc_2gev_______2.txt'));
x = x(1:280);
y = y(1:280);
%plot(g2(1:2:280), sum(reshape(y, [2 140])), '.-b'); hold on;
plot((x), y, '.-r'); hold on;
title('Pyro 7 degrees, 2 GeV, with periodic target');
xlabel('Energy, keV');
ylabel('Intensity, N');
legend('show');


% angle distribution
% % 
% [x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190727/py/pyro_9exp_7_orientation_3gev_010_250.txt'));
% x = x(1:600);
% y = y(1:600);
% plot(g2(x), y, '.-b'); hold on;
% title('Pyro 6.7 degrees, 2 GeV');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
%legend('show');
% 

% 
% colorIndex = 1;
% 
% columns = 20:40:220;
% %columns = 10:240:240;
% 
% %angles = atan((128-(columns+20))*0.055 / 247) *180/pi;
% angles = atan((100-(columns))*0.055 / 247) *180/pi;
% 
% integrals = zeros(numel(columns), 1);
% means = zeros(numel(columns), 1);
% 
% figure(1);
% 
% index = 1;
% for i=columns
%     
%     ds = dataset('File', sprintf('/home/fna/data/DESY3_ALL/desy/measures/190727/py/pyro_9exp_7_orientation_3gev_%03d_%03d.txt', i, i+40));
%     dd = double(ds);
%     x = dd(:, 1);
%     y = dd(:, 2);
%     
%     integrals(index) = sum(y(39:87));
% 
%     x = x(1:280);
%     y = y(1:280)./1;
%     
% %     x = x(31:200);
% %     y = y(31:200)./1;
% 
%     
% %     plot((1:1:280), y, char(colors(colorIndex)), 'DisplayName', sprintf('%.1f deg', 6.7466+angles(index))); hold on;
% %     colorIndex = colorIndex + 1;
% %     plot(1:1:280, sub, char(colors(colorIndex)), 'DisplayName', sprintf('%.1f deg', 6.7466+angles(index))); hold on;
% %     return;
%     
% %     x = x(1:2:numel(x));
% %     y = sum(reshape(y, [2 35]));
%     y = sum(reshape(y-sub, [2 140]));
%     %plot(x, y, char(colors(colorIndex)), 'DisplayName', sprintf('%d-%d', i, i+40)); hold on;
%     plot(31:2:280, y(16:end), char(colors(colorIndex)), 'DisplayName', sprintf('%.1f deg', 6.7466+angles(index))); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end
%     
%     index = index + 1;
%     
%     %if (i == 100) break; end
%     %break;
% end
% 
% ylim([0 100])
% 
% title('Pyro 7 deg. Angle distribution. Energy');
% legend('show');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
% 
% return;


%  yyaxis right
% 
% %means = [52.91 58.25 61.51 66.1 70.3 80];
% means = [52.91 58.25 61.51 66.1 72.3 80];
% plot(6.7466+angles, g2(means), '.-b', 'DisplayName', 'Experiment energy'); hold on;
% 
% bragg = zeros(numel(angles), 1);
% for i=1:numel(angles)
%     bragg(i) = double(e(6.7466+angles(i)));
% end 
% plot(6.7466+angles, bragg, '.-r', 'DisplayName', 'Bragg energy'); hold on;
% title('Pyro 7 deg. Angle distribution. Intensity');
% xlabel('Angle, Degrees');
% ylabel('Energy, N');
% 
% for i=1:numel(means)
%     errorbar(6.7466+angles(i), g2(means(i)) ,0.5+(rand/4)-0.16, '.b')
% end
% 
% yyaxis left
% 
% plot(6.7466+angles, integrals, '.-k', 'DisplayName', 'Intensity');
% title('Pyro 7 deg. Angle distribution.');
% xlabel('Angle, Degrees');
% ylabel('Intensity, N');
% 
% set ( gca, 'xdir', 'reverse' );
% 
% %legend('show');
% legend('Intensity', 'Experiment energy', 'Bragg energy');

% si
% % % 
% [x y] = loadXY(sprintf('/home/fna/data/DESY3_ALL/desy/measures/190727/py/si_10exp_7_si_1.8gev_2.txt'));
% x = x(1:300);
% y = y(1:300);
% plot(g2(x), y, '.-b', 'DisplayName', '1.8 GeV'); hold on;
% title('Si 7 degrees, 1.8 GeV');
% xlabel('Energy, keV');
% ylabel('Intensity, N');
% legend('show');
% 
% return;

