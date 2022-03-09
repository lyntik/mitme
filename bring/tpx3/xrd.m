
figure('Renderer', 'painters', 'Position', [10 10 400 300]);
set(0,'defaultAxesFontSize',12)

colorIndex = 1;

angles = {
%     '6.5'
     '7'
%     '7.5'
%     '10'
%     '15'
    };

energies = {
%     '28.49'
     '26.47'
%     '24.65'
%     '18.52'
%     '12.38'
    };



i = 3;

ymax = -1;

for a = 1:numel(angles)
    [x y] = loadXY(sprintf('/home/fna/dev/pixetsdk/XRD/%s/%d_b.txt', char(angles(a)), i));
    
    x = x(1:100);
    y = y(1:100);
   
    y_back = y;

    [x y] = loadXY(sprintf('/home/fna/dev/pixetsdk/XRD/%s/%d.txt', char(angles(a)), i));
    
    x = x(1:100);
    y = y(1:100);
    
%     plot((x), (y_back), char(colors(colorIndex)), 'DisplayName', sprintf('%s energy', char(angles(a))));  hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end   
%         
    y = y - y_back;
    if (max(y) > ymax)
        ymax = max(y);
    end

    plot((x), y, char(colors(colorIndex)), 'DisplayName', sprintf('%s keV', char(energies(a))), 'LineWidth', 1.5);  hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end       
        
end

ylim([0 ymax*0.95])

%xlabel('TOT', 'FontSize', 8);
xlabel('TOT');
ylabel('Intensity, N');
%stitle(sprintf('X-Ray Diffraction. Crystal Si 220. %d cluster', i));
legend('show');
print('-clipboard','-dbitmap');

return;


% cluster 1
e = [   49.3 37.04 26.47  24.65  18.52  12.38  ];
mean = [ 42    31    22     20     14    8  ];
%      f(x) = a*x+b-c/(x-t)
% Coefficients (with 95% confidence bounds):
%        a =      0.8283  (0.09878, 1.558)
%        b =       3.348  (-75.49, 82.18)
%        c =       137.7  (-3177, 3452)
%        t =      -12.03  (-300, 275.9)
plot(e, mean, '.-b', 'DisplayName', 'XRD'); hold on;


% cluster 2
e = [   56.98   52.94     49.3 37.04 26.47  24.65  18.52  ];
mean = [ 54       49.5     46    34    24     22     15    ];
%      f(x) = a*x+b-c/(x-t)
% Coefficients (with 95% confidence bounds):
%        a =      0.9928  (-3.736, 5.721)
%        b =      -2.779  (-1105, 1100)
%        c =      0.4879  (-1.369e+05, 1.369e+05)
%        t =      -62.95  (-9.08e+06, 9.08e+06)


% cluster 3
e = [     79.41  56.98   52.94     49.3 37.04   28.49  26.47  24.65  ];
mean = [   77     55       50     46    32.8     22    19      17    ];
%        a =           1  (fixed at bound)
%        b =     -0.4772  (-2.864, 1.91)
%        c =       101.4  (-30.02, 232.8)
%        t =       11.14  (-3.29, 25.58)

return;

i = 1;

%for e = 1:numel(energies)

    [x y] = loadXY(sprintf('/home/user/dev/pixetsdk/%d_b.txt', i));
    
    x = x(1:150);
    y = y(1:150);
   
    y_back = y;

    [x y] = loadXY(sprintf('/home/user/dev/pixetsdk/%d.txt', i));
    
    x = x(1:150);
    y = y(1:150);
    
      %y = y - y_back;
% %    
      y = y./sum(y);
    
%    plot((x), (y_back), char(colors(colorIndex)), 'DisplayName', sprintf('%s energy', char(energies(e))));  hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end   
%         
    plot((x), log(y), char(colors(colorIndex)), 'DisplayName', 'current');  hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end   
    
%end

legend('show');


% return;

% %%
% 
% energies = {
%     '12.47'
%     %'14.9187'
%     '21.84'
%     %'24.74'
%     '26.5'
%     };
% 
% 
% i = 2;
% 
% %colorIndex = 1;
% 
% for e = 1:numel(energies)
%     
%     [x y] = loadXY(sprintf('/home/user/dev/pixetsdk/diffraction/%s/%d.txt', char(energies(e)), i));
%     
%     x = x(1:100);
%     y = y(1:100);
%     
% 
%     y = y./sum(y);
%     
%     plot((x), (y), char(colors(colorIndex)), 'DisplayName', sprintf('%s energy', char(energies(e))));  hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end   
%     
% end
% 
% legend('show');

%%



energies = {
    '28.5'
    '30.89'
    };


for e = 1:numel(energies)
    
    [x y] = loadXY(sprintf('/home/user/dev/pixetsdk/diffraction/hv_less/%s/%d.txt', char(energies(e)), i));
    
    x = x(1:100);
    y = y(1:100);
    
    y = y./sum(y);
    
    plot((x), log(y), char(colors(colorIndex)), 'DisplayName', sprintf('%s energy', char(energies(e))));  hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end   
    
end

legend('show');


%     [x y] = loadXY(sprintf('/home/user/dev/pixetsdk/XRD/5.5/75hv/2.txt'));
%     
%     x = x(1:100);
%     y = y(1:100);
%     
%     y = y./sum(y);
%     
%     plot((x), log(y), char(colors(colorIndex)), 'DisplayName', sprintf('%s energy', char(energies(e))));  hold on;
%     colorIndex = colorIndex + 1;
%     if (colorIndex == 8)
%         colorIndex = 1;
%     end   
%     
% 
% legend('show');




