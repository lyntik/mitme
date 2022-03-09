


%------ spectrometer calibration
% x = [176.89 214.77 225.41 334.24 756.66];
% y = [13.94 17.06 17.75 26.34 59.54];
% p1 = 0.07858;
% p2 = 0.08479;
% syms x;
% f(x) = p1*x+p2;

%------ medipix2 calibration
%%%% 6 kev
%%% 1 cluster
% syms x
% f(x) = 2.99*x+80-630.9/(x+2.316);
% g1 = finverse(f)
% %%% 2 cluster
% syms x
% f(x) = 2.591*x+189.1-3442/(x+9.985);
% g2 = finverse(f)


%%%% 8 kev
% syms x
% % f(x) = 1.719*x+33-96.84/(x-6);
% f(x) = 2.791*x+55.75-273.6/(x-5.759);
% g1 = finverse(f)
% 
% syms x
% %f(x) = 1.911*x+45.32-316.4/(x-6.438);
% f(x) = 4.863*x-1.916-140.6/(x-8);
% g2 = finverse(f)
% 
% syms x
% f(x) = 2.453*x+34.76-1119/(x-0.02753);
% g3 = finverse(f)

%------ day2
%---------- medipix
% figure('rend', 'painters', 'pos', [500 500 1100 800]);
% subplot(2,1,1);
% suptitle({'day2', 'medipix', 'crystall 5 deg (2 cluster)'}); 
% 
% [x, y1] = loadXY('/home/fna/data/desy2/data/181002/py/5_degrees_background_2.txt');
% plot(g2(x) / 10, y1, '.-b', 'DisplayName', 'background'); hold on;
% [x, y2] = loadXY('/home/fna/data/desy2/data/181002/py/5_degrees_2.txt');
% plot(g2(x) / 10, y2, '.-r', 'DisplayName', '5 degrees'); hold on;
% 
% xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');
% 
% subplot(2,1,2);
% plot(g2(x) / 10, y2 - y1, '.-r'); hold on;
% title('substruction');  xlabel('Energy, keV'); ylabel('Counts, N');

%---------- spectrometer
% [y] = loadMCA('/home/fna/data/desy2/data/181002/spectrometer/5_75_degrees.mca'); x = f(1:numel(y)); x = x(1:1000); y = y(1:1000);
% plot(x, y, '.-b');
% title({'day2', 'spectrometer', 'crystall 5.75 deg'}); xlabel('Energy, keV'); ylabel('Counts, N');

%------ day3
%---------- spectrometer
%--------------- different angles
% [y] = loadMCA('/home/fna/data/desy2/data/181003/spectrometer/5c_11d.mca'); x = f(1:numel(y)); x = x(1:1000); y = y(1:1000);
% plot(1:numel(y), y, '.-b', 'DisplayName', 'crystall 5 deg, detector 11 deg'); hold on;
% 
% [y] = loadMCA('/home/fna/data/desy2/data/181003/spectrometer/5c_9.75d.mca'); x = f(1:numel(y)); x = x(1:1000); y = y(1:1000);
% plot(x, y, '.-r', 'DisplayName', 'crystall 5 deg, detector 9.75 deg'); hold on;
% 
% [y] = loadMCA('/home/fna/data/desy2/data/181003/spectrometer/5c_8d.mca'); x = f(1:numel(y)); x = x(1:1000); y = y(1:1000);
% plot(x, y, '.-g', 'DisplayName', 'crystall 5 deg, detector 8 deg'); hold on;
% title({'day3', 'spectrometer', 'crystall 5 deg'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');

%--------------- different angles (more)
% colorIndex = 1;
% views = [ 8 8.5 9.5 9.75 10 11 ];
% views = 8;
% 
% for v=views
%     [y] = loadMCA(sprintf('/home/fna/data/desy2/data/181003/spectrometer/5c_%gd.mca', v)); 
%     %y = y(1:1000); x = f(5:10:numel(y)); y = reshape(y, [10 100]); y = sum(y, 1); 
%     y = y(1:1000); x = f(1:1000); 
%     vv = 9;
%     plot(x, y, char(colors(colorIndex)), 'DisplayName', sprintf('crystall 5 deg, detector %g deg', vv)); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end
% end
% title({'day 3', 'spectrometer', 'crystall 5 deg. various view angles'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');

%views = [ 8 8.5 9.5 9.75 11 ];
% en = [ 25.62 24.84 24.05 21.69 20.12 ];
% plot(views, en, '.-b');

% views = [ 8 8.5 9.5 9.75 10 11 ];
% en = [ 25.31 24.68 23.34 22.01 22.24 19.26 ];
% plot(views, en, '.-b');

%--------------- different energies
% 
% colorIndex = 1;
% energies = [ 1.8 3.8 4.8 ];
% 
% for e=energies
%     [y] = loadMCA(sprintf('/home/fna/data/desy2/data/181003/spectrometer/5c_9.75d_energy%g.mca', e)); 
%     y = y(1:1000); x = f(5:10:numel(y)); y = reshape(y, [10 100]); y = sum(y, 1); 
%     %y = y(1:1000); x = f(1:1000); 
%     plot(x, y, char(colors(colorIndex)), 'DisplayName', sprintf('%g energy', e)); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end
% end
% title({'day 3', 'spectrometer', 'crystall 5 deg, detector 9.75 various energies'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');

%---------- medipix

% [x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_5c_9.75d_2.txt');
% plot(g2(x) / 10, y, '.-b', 'DisplayName', ''); hold on;
% [x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_5c_9.75d_magn1400__2.txt');
% plot(g2(x) / 10, y, '.-r', 'DisplayName', 'with magn'); hold on;
% title({'day 3', 'medipix', 'crystall 5 deg, detector 9.75'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');


%------ day4 ... mix..

%---------- medipix

%--------------- crystall angels
% 
% [x, y] = loadXY('/home/fna/data/desy2/data/181004/py/max_3c_6d_2.txt'); x = x(1:500); y = y(1:500);
% plot(g2(x), y, '.-r', 'DisplayName', '3c-6d'); hold on;
% [x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_4c_8d_2.txt'); x = x(1:500); y = y(1:500);
% plot(g2(x), y, '.-g', 'DisplayName', '4c-8d'); hold on;
% [x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_5c_9.75d_2.txt'); x = x(1:500); y = y(1:500);
% plot(g2(x), y, '.-b', 'DisplayName', '5.5c-11d'); hold on;
% title({'medipix', 'crystall 3, 4, 5.5 deg'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');
% %-
% [x, y] = loadXY('/home/fna/data/desy2/data/181004/py/max_3c_6d_2.txt'); x = x(1:500); y = y(1:500);
% plot(g2(x), y - sub, '.-r', 'DisplayName', '3c-6d'); hold on;
% [x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_4c_8d_2.txt'); x = x(1:500); y = y(1:500);
% plot(g2(x), y - sub, '.-g', 'DisplayName', '4c-8d'); hold on;
% [x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_5c_9.75d_2.txt'); x = x(1:500); y = y(1:500);
% plot(g2(x), y - sub, '.-b', 'DisplayName', '5.5c-11d'); hold on;
% title({'medipix', 'crystall 3, 4, 5.5 deg (background is substracted)'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');



%--------------- crystall angels fit

% exps = {'5c_9.75d', '4c_8d', '3c_6d' };
% exps2 = {'5.5c\_11d', '4c\_8d', '3c\_6d' };
% 
% colorIndex = 1;
% 
% for i=1:numel(exps)
%     [x, y] = loadXY(sprintf('/home/fna/data/desy2/data/181003/py/max_%s_2.txt', char(exps(i)))); x = x(1:500); y = y(1:500);
%     x = double(g2(x));
%     y = y - sub;
%     [xData, yData] = prepareCurveData( x, y );
%     
% %     ft = fittype( 'gauss2' );
% %     
% %     opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% %     opts.Lower = [-Inf -Inf 0 -Inf -Inf 5 -Inf -Inf 0];
% %     if (i == 1)
% %         ft = fittype( 'gauss3' );
% %     elseif (i == 3)
% %         opts.Lower = [-Inf -Inf 0 -Inf -Inf 0 ];
% %         opts.Upper = [Inf Inf Inf Inf 21 Inf ];
% %     end    
%     ft = fittype( 'gauss1' );
%     opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
%     
%     opts.Display = 'Off';
%     [fitresult, gof] = fit( xData, yData, ft, opts );
%     index = 1;
%     yfit = zeros(numel(y), 1);
%     for xx=x'
%         yfit(index) = feval(fitresult, xx);
%         index = index + 1;
%     end
%     plot(x, yfit, char(colors(colorIndex)), 'DisplayName', char(exps2(i))); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end
% end    
% 
% title({'medipix', 'crystall 3, 4, 5.5 deg (fit)'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');

%--------------- 5 crystall with/without magn
% [x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_5c_9.75d_2.txt'); x = x(1:500); y = y(1:500);
% plot(g2(x) / 1, y, '.-b', 'DisplayName', '5.5c\_11d'); hold on;
% y1 = y;
[x, y] = loadXY('/home/fna/data/desy2/data/181003/py/max_5c_9.75d_magn1400__2.txt'); x = x(1:500); y = y(1:500);
x = gg2(x);
%  plot(g2(x) / 1, y, '.-r', 'DisplayName', '5.5c\_11d with magn'); hold on;
% title({'medipix', 'crystall 5.5 deg (with/without magnet field)'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');
% sub = y;
% plot(g2(x) / 1, y1 - sub, '.-k', 'DisplayName', 'sub'); hold on;


%--------------- direct with/without magn

% figure('rend', 'painters', 'pos', [500 500 1100 800]);
% subplot(2,1,1);
% suptitle({'medipix', 'direct (with and without magnet field)'}); 
% [x, y] = loadXY('/home/fna/data/desy2/data/181004/py/direct2_8_2.txt'); x = x(1:2000); y = y(1:2000);
% plot(g2(x), y, '.-b', 'DisplayName', 'direct'); hold on;
% [x, y] = loadXY('/home/fna/data/desy2/data/181004/py/direct2_8_magn_2.txt'); x = x(1:2000); y = y(1:2000);
% plot(g2(x), y, '.-r', 'DisplayName', 'direct with magn'); hold on;
% title('linear'); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');
% subplot(2,1,2);
% [x, y] = loadXY('/home/fna/data/desy2/data/181004/py/direct2_8_2.txt'); x = x(1:2000); y = y(1:2000);
% plot(g2(x), log10(y), '.-b', 'DisplayName', 'direct'); hold on;
% [x, y] = loadXY('/home/fna/data/desy2/data/181004/py/direct2_8_magn_2.txt'); x = x(1:2000); y = y(1:2000);
% plot(g2(x), log10(y), '.-r', 'DisplayName', 'direct with magn'); hold on;
% title('log10'); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');


%--------------- 4_5c (radiator as always), with/without cu
% [y] = loadMCA('/home/fna/data/desy2/data/181005/spectrometer/4_5c_10_5d_250Hz_Al_radiator.mca'); 
% y = y(1:1000); x = f(5:10:numel(y)); y = reshape(y, [10 100]); y = sum(y, 1); 
% %y = y(1:1000); x = f(1:1000); 
% plot(x, y, '.-b', 'DisplayName', 'radiator'); hold on;
% [y] = loadMCA('/home/fna/data/desy2/data/181005/spectrometer/4_5c_10_5d_250Hz_Cu.mca'); 
% y = y(1:1000); x = f(5:10:numel(y)); y = reshape(y, [10 100]); y = sum(y, 1); 
% %y = y(1:1000); x = f(1:1000); 
% plot(x, y, '.-r', 'DisplayName', 'radiator\_cu'); hold on;
% title({'spectrometer', 'crystall 5.75 deg al radiator (with/without cu filter)'}); xlabel('Energy, keV'); ylabel('Counts, N'); legend('show');

%--------------- focus_positron_en2g_vacuum_0mbar.txt
% exps = { '0', '190-160', '330-300', '440-480', '570-560', '570-560', '760-750', '880-770' };
% exps = { '0', '190-160', '330-300', '570-560', '760-750', '880-770' };
% 
% colorIndex = 1;
% for i=1:numel(exps)
%     ds = dataset('File', sprintf('/home/fna/data/desy2/data/181006/focus_positron_en2g_vacuum_%smbar.txt', char(exps(i))));
%     cellArray = cellstr(ds);
%     str = char(cellArray(1));
% 
%     C = char(strsplit(str, ' '));
% 
%     dd = zeros(256, 1);
%     for col = 1:256
%         dd(col) = str2double(C(col, :));
%     end
% 
%     x = 1:256;
%     y = dd;
% 
%     plot(1:256, dd, char(colors(colorIndex)), 'DisplayName', strcat(char(exps(i)), ' mbar')); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end    
%     
% end
% title({'medipix2 focus positron'}); xlabel('Column'); ylabel('Counts, N'); legend('show');



return;



figure(2);

%[x, y] = loadXY('/home/fna/dev/B3/B3a/build/heh');
[x, y] = loadXY('/home/fna/dev/g4course2011/day2d/build/heh');
size(y)
% 
% y = reshape(y, [50 200]);
% y = sum(y, 1);

% y = reshape(y, [50 200]);
% y = sum(y, 1);

% y = reshape(y, [20 500]);
% y = sum(y, 1);
% % 
y = reshape(y, [10 1000]);
y = sum(y, 1);  


x = 1:numel(y);
plot(1:numel(y), y, '.-r'); hold on;

title({'Decay pos distribution', 'kaon+ 0.1 GeV, decay channel(s): (0.6355, mu+, nu\_mu), lifetime: 12.38 ns', 'issue: no peak', ''});
xlabel('Position, mm');
ylabel('Counts, N');




