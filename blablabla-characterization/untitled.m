
%%% count char

% = [0 20 40];

dist = [0 10 20 30 40];
totalcount = [180684 239249 329140 465140 610280 ];
plot(15+40-dist, totalcount, '.-b');
title('count char'); xlabel('Distance, cm'); ylabel('Total count, N'); legend('show');

return;

colorIndex = 1;

for i = [0 10 20 30 40]
    
    [y] = loadMCA(sprintf('/home/fna/data/our/7/measure2/count_char/%d.mca', i));
    y = y(1:8000);

    y = reshape(y, [8, 1000]);
    y = sum(y, 1);

    plot((1:numel(y)).*8-4, y, char(colors(colorIndex)), 'DisplayName', sprintf('sdd: ~15cm+%dcm', 40-i)); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end

title('count char'); xlabel('Channel'); ylabel('Count, N'); legend('show');

return;


% 
% %%% drifting
% 
% 
% colorIndex = 1;
% 
% means = zeros(30, 1);
% means2 = zeros(30, 1);
% 
% for i = 0:29
%     
%     [y] = loadMCA(sprintf('/home/fna/data/our/7/measure2/drifting/0busy/%04d.mca', i));
%     y = y(1001:2500);
%     y = reshape(y, [4, 375]);
%     y = sum(y, 1);
%     [coeffs] = fito(1001:4:numel(y)*4+1000, y, 'gauss1');
%     means(i+1) = coeffs(2);
%     
%     [y] = loadMCA(sprintf('/home/fna/data/our/7/measure2/drifting/0busy_1/%04d.mca', i));
%     y = y(1001:2500);
%     y = reshape(y, [4, 375]);
%     y = sum(y, 1);
%         
%     [coeffs] = fito(1001:4:numel(y)*4+1000, y, 'gauss1');
%     means2(i+1) = coeffs(2);    
% end
% 
% 
% plot(1:30, means, '.-b', 'DisplayName', 'Turn1'); hold on;
% plot(1:30, means2, '.-r', 'DisplayName', 'Turn2'); hold on;
% 
% title('drifting'); xlabel('Measurement'); ylabel('Mean'); legend('show');
% 
% 
% return;


%%% busy-mean
% 
% exps = { '25_0.2ma_al_cu-65kev-286rate-0dead', '25_0.5ma_al_cu-65kev-618rate-0dead', '25_0.7ma_al_cu-65kev-847rate-0dead', '25_1ma_al_cu-65kev-1176rate-0dead', '25_1.5ma_al_cu-65kev-1723rate-5.4dead', '25_2ma_al_cu-65kev-2269rate-5.4dead', '25_3ma_al_cu-65kev-3372rate-16dead',  '25_4ma_al_cu-65kev-4416rate-22dead', '25_5ma_al_cu-65kev-5440rate-27dead', '25_6ma_al_cu-65kev-6451rate-31dead', '25_7ma_al_cu-65kev-7479rate-36dead', '25_8ma_al_cu-65kev-8471rate-39dead'};
% exps_ = strrep(exps, '_', '\_');
% 
% figure(2);
% 
% colorIndex = 1;
% 
% means = zeros(numel(exps), 1);
% x = zeros(numel(exps), 1);
% expression = '(\d+)rate';
% firstmean = 0;
% 
% for i = 1:numel(exps)
%     
%     [y] = loadMCA(sprintf('/home/fna/data/our/7/measure2/busy_char/%s.mca', char(exps(i))));
%     y = y(1001:2500);
% 
%     y = reshape(y, [4, 375]);
%     y = sum(y, 1);
% 
%     [coeffs] = fito(1001:4:numel(y)*4+1000, y, 'gauss1');
%     
%     if (i == 1)
%         firstmean = coeffs(2);
%     end
%         
%     str = char(exps(i));
%     x(i) = sscanf(str(regexp(str,expression):numel(str)), '%d');        
% 
%     means(i) = firstmean - coeffs(2);
% 
% %     plot(x, y, char(colors(colorIndex)), 'DisplayName', sprintf('%s', char(exps_(i)))); hold on;
% %     colorIndex = colorIndex + 1;
% %     if (colorIndex == 8)
% %         colorIndex = 1;
% %     end
% end
% 
% 
% 
% plot(x, means, '.-b');
% 
% title('mean-diff-to-286-rate vs input-rate'); xlabel('Input Rate, N'); ylabel('Mean Diff to 286 rate'); legend('show');
% 
% 
% return;


% syms x;
% a =       15.33;
% b =   0.0007366;
% c =    0.001023;
% d =    0.002868;
% f(x) = a*exp(b*x) + c*exp(d*x);



channels = [701    1573      913    1945       1161   2085      1481  2429            ]
energies = [24.39  24.39*2   30.68  30.68*2    37.05  37.05*2   46.3  46.3 * 2        ]

channels48 = [1633 2645 ]
energies48 = [50.49  50.49*2]

channels_ba = [897 1913 4713 ]
energies_ba = [31 81 356 ]

% channels = [565   1281    949    1801     1425      1953    ]
% energies = [20.21 40.42   30.68  61.35    41.42     60        ]
% 
% channels20 = [565   1281 ]
% energies20 = [20.21 40.42  ]
% 
% channels30 = [949    1801];
% energies30 = [30.68  61.35];
% 
% channels40 = [1425];
% energies40 = [41.42];
% 
% channels60 = [1953 4340 4720 2576];
% energies60 = [80 303 356 120];
% 
% plot(channels20, energies20, '.-b', 'DisplayName', '20-40'); hold on;
% plot(channels30, energies30, '.-g', 'DisplayName', '30-60'); hold on;
% plot(channels40, energies40, '.-r', 'DisplayName', '40'); hold on;
% plot(channels60, energies60, '.-k', 'DisplayName', '60'); hold on;
% 
% legend('show');
% 
plot(channels, energies, '.-b', 'DisplayName', '20-40'); hold on;
plot(channels48, energies48, '.-r', 'DisplayName', '20-40'); hold on;
plot(channels_ba, energies_ba, '.-k', 'DisplayName', '20-40'); hold on;
% 
return;



% figure(3);
% 
% exps = {'60_0.7ma_al_7cu_3pb_160kev', '70_0.7ma_al_7cu_3pb_160kev', '0_0.7ma_al_7cu_3pb_160kev'  };
% exps_ = {'60\_0.7ma\_al\_7cu\_3pb\_160kev', '70\_0.7ma\_al\_7cu\_3pb\_160kev', '0\_0.7ma\_al\_7cu\_3pb\_160kev'  };
% 
% %energies = 35;
% 
% figure('rend', 'painters', 'pos', [500 500 1100 800]);
% subplot(2,1,1);
% suptitle({'', 'blablabla spectrometer characterization'}); 
% 
% colorIndex = 1;
% for i = 1:numel(exps)
% 
%     
%     [y] = loadMCA(sprintf('/home/fna/data/our/7/measure2/%s.mca', char(exps(i))));
%     y = y(1:4000);
%     
%     y = reshape(y, [4, 1000]);
%     y = sum(y, 1);
%     
%     if (i == 1) y1 = y;
%     elseif (i == 2) y2 = y;
%     end
%     
%     plot(f(1:4:numel(y)*4), (y), char(colors(colorIndex)), 'DisplayName', sprintf('%s', char(exps_(i)))); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end
% end
% 
% % plot(1:4:numel(y)*4, (y1 - y2), char(colors(colorIndex)), 'DisplayName', sprintf('%s diff', char(exps(i)))); hold on;
% % colorIndex = colorIndex + 1;
% % if (colorIndex == 8)
% %     colorIndex = 1;
% % end
% 
% title('linear'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');
% 
% 
% %exps = {'12.5-1ma-cufoil', '15-1ma-cufoil', '17.5-1ma-cufoil', '20-1ma-cufoil', '22.5-1ma-cufoil', '25-1ma-cufoil', '27.5-1ma-cufoil' };
% 
% %energies = 35;
% 
% subplot(2,1,2);
% 
% colorIndex = 1;
% for i = 1:numel(exps)
%     [y] = loadMCA(sprintf('/home/fna/data/our/7/measure2/%s.mca', char(exps(i))));
%     y = y(1:4000);
%     
%     y = reshape(y, [4, 1000]);
%     y = sum(y, 1);    
%     
%     if (i == 1) y1 = y;
%     elseif (i == 2) y2 = y;
%     end    
%     
%     plot(f(1:4:numel(y)*4), log10(y), char(colors(colorIndex)), 'DisplayName', sprintf('%s', char(exps_(i)))); hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end
% end
% 
% title('log10'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');
% 
% return;
figure(3);


%energies = 35;

syms x;
f(x)=x;
%plotMeasuresWithDiffrence('/home/fna/105/our/7/measure2', {'24_0.3ma-al-65kev', '0_0.3ma-al-65kev'}, f);
%plotMeasuresWithDiffrence('/home/fna/105/our/7/measure2', {'30_0.7ma-al_cu-65kev', '0_0.7ma-al_cu-65kev'}, f);
%plotMeasuresWithDiffrence('/home/fna/105/our/7/measure2', {'36_0.2ma-al_cu-80kev', '0_0.2ma-al_cu-80kev'}, f);
%plotMeasuresWithDiffrence('/home/fna/105/our/7/measure2', {'44_0.2ma-al_3cu-100kev', '0_0.2ma-al_3cu-100kev'}, f);
%plotMeasuresWithDiffrence('/home/fna/105/our/7/measure2', {'48_0.2ma_al_4cu_115kev', '0_0.2ma_al_4cu_115kev'}, f);




return;

% bder ki11
% 
% syms x;
% g(x) = 0.0146 * x - 0.1534;

energies = [24 30 36 44 48];

% for e = energies
%     convertToMatlabCompatibleXY(sprintf('/home/fna/data/bder/%d.asc', e), sprintf('/home/fna/data/bder/%d_.asc', e), 'channel', 'c');
% end

figure('rend', 'painters', 'pos', [500 500 1100 800]);
subplot(2,1,1);
suptitle({'', 'bder ki11 spectrometer characterization'}); 

colorIndex = 1;
for e = energies
    [x, y] = loadXY(sprintf('/home/fna/data/bder/%d_.asc', e));
    
    plot(g(x), y, char(colors(colorIndex)), 'DisplayName', sprintf('%d keV', e)); hold on;
        colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end

title('linear'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');


subplot(2,1,2);

colorIndex = 1;
for e = energies
    [x, y] = loadXY(sprintf('/home/fna/data/bder/%d_.asc', e));
    
    plot(g(x), log10(y), char(colors(colorIndex)), 'DisplayName', sprintf('%d keV', e)); hold on;
        colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end

title('log10'); xlabel('Energy, keV'); ylabel('Count, N'); legend('show');


