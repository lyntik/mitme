
% Intensity
global colorIndex;
colorIndex = 1;
global colors;

% figure(2);
% path = '/home/fna/scans/CsI/tomo/plastic2';
% t = Tiff(sprintf('%s/img_0000.tif', path), 'r');
% img = read(t);
% %img = flip(img, 2);
% imagesc(img);
% 
% 
% y = 494:500;
% 
% g = zeros(684, 1);
% i = 1;
% f = -1;
% for xx=4201:f:3518
%     %mean(img(y, xx))
%     g(i) = mean(img(y, xx));
%     i = i + 1;
%     
% end
% %g = g ./ sum(g);
% plot(1:numel(g), g, '.-b');
% 
% [v i] = max(gradient(g));
% 
% 
% y
% xx
% mean(img(y, xx))
% 
% return;   
% 
% % % % 
% t = Tiff('c:\scans\axe\exp13\027\0000.tif','r');
% img = read(t);
% img = img';
% imagesc(img);

% % % 
%  return;


%plotAxePlay3('c:/scans/axe/exp4/norot', 1, 30, 926, 966, 890:900, 'x', "per", 'axe', 0);
%plotAxePlay3('c:/scans/axe/exp4/norot', 1, 30, 1500, 1485, 650:660, 'x', "per", 'reference', 1);
%plotAxePlay3('c:/scans/axe/exp4/norot', 1, 30, 498, 470, 30:40, 'y', "per", 'axe', 1);
%plotAxePlay3('c:/scans/axe/exp4/norot', 1, 30, 967, 990, 1897:1907, 'y', "per", 'reference', 0);

%plotAxePlay3('c:/scans/axe/exp4/0-360', 1, 30, 926, 966, 890:900, 'x', "per", 'axe', 0);
%plotAxePlay3('c:/scans/axe/exp4/0-360', 1, 30, 1500, 1485, 650:660, 'x', "per", 'reference', 1);
%plotAxePlay3('c:/scans/axe/exp4/0-360', 1, 30, 498, 470, 30:40, 'y', "per", 'axe', 1);
%plotAxePlay3('c:/scans/axe/exp4/0-360', 1, 30, 967, 990, 1897:1907, 'y', "per", 'reference', 0);

%plotAxePlay3('c:/scans/axe/exp4/0-360_2', 1, 30, 926, 966, 890:900, 'x', "per", 'axe', 0);
%plotAxePlay3('c:/scans/axe/exp4/0-360_2', 1, 30, 1500, 1485, 650:660, 'x', "per", 'reference', 1);
%plotAxePlay3('c:/scans/axe/exp4/0-360_2', 1, 30, 498, 470, 30:40, 'y', "per", 'axe', 1);
%plotAxePlay3('c:/scans/axe/exp4/0-360_2', 1, 30, 967, 990, 1897:1907, 'y', "per", 'reference', 0);


%plotAxePlay3('c:/scans/axe/exp4/norot2', 1, 30, 926, 966, 890:900, 'x', "per", 'axe', 0);
%plotAxePlay3('c:/scans/axe/exp4/norot2', 1, 30, 1500, 1485, 650:660, 'x', "per", 'reference', 1);
%plotAxePlay3('c:/scans/axe/exp4/norot2', 1, 30, 498, 470, 30:40, 'y', "per", 'axe', 1);
%plotAxePlay3('c:/scans/axe/exp4/norot2', 1, 30, 967, 990, 1897:1907, 'y', "per", 'reference', 0);

% exp5
%plotAxePlay3('c:/scans/axe/exp5/norot', 1, 30, 743, 792, 890:900, 'x', "per", 'axe', 0);
%plotAxePlay3('c:/scans/axe/exp5/norot', 1, 30, 1500, 1485, 650:660, 'x', "per", 'reference', 1);
%plotAxePlay3('c:/scans/axe/exp5/norot', 1, 30, 548, 533, 10:20, 'y', "per", 'axe', 1);
%plotAxePlay3('c:/scans/axe/exp5/norot', 1, 30, 967, 990, 1897:1907, 'y', "per", 'reference', 0);

%plotAxePlay3('c:/scans/axe/exp5/norot2', 1, 30, 743, 792, 890:900, 'x', "per", 'axe', 0);
%plotAxePlay3('c:/scans/axe/exp5/norot2', 1, 30, 1500, 1485, 650:660, 'x', "per", 'reference', 1);
%plotAxePlay3('c:/scans/axe/exp5/norot2', 1, 30, 548, 533, 1:30, 'y', "per", 'axe', 1);
%plotAxePlay3('c:/scans/axe/exp5/norot2', 1, 30, 967, 990, 1897:1957, 'y', "per", 'reference', 0);
% 

% plotAxePlay3('c:/scans/axe/exp8/norot', 1, 10, 609, 632, 1977:1987, 'y', "per", 'axe', 0);
% plotAxePlay3('c:/scans/axe/exp8/norot', 1, 10, 856, 760, 1947:1957, 'y', "per", 'axe2', 1);
% plotAxePlay3('c:/scans/axe/exp8/norot', 1, 10, 633, 602, 15:20, 'y', "per", 'reference', 1);


% plotAxePlay3('c:/scans/axe/exp8/norot4', 1, 20, 415, 450, 2126:2136, 'y', "per", 'reference', 0);
% plotAxePlay3('c:/scans/axe/exp8/norot4', 1, 20, 670, 619, 420:430, 'y', "per", 'axe', 1);
% plotAxePlay3('c:/scans/axe/exp8/norot4', 1, 20, 865, 846, 2107:2112, 'y', "per", 'axe2', 1);

% plotAxePlay3('c:/scans/axe/exp8/norot4', 1, 20, 1882, 1824, 260:270, 'x', "per", 'reference', 1);
% plotAxePlay3('c:/scans/axe/exp8/norot4', 1, 20, 937, 975, 1000:1010, 'x', "per", 'axe', 0);
% plotAxePlay3('c:/scans/axe/exp8/norot4', 1, 20, 1941, 1893, 1052:1062, 'x', "per", 'axe2', 1);


% plotAxePlay3('c:/scans/axe/exp8/norot5', 1, 10, 415, 450, 2126:2136, 'y', "per", 'reference', 0);
% plotAxePlay3('c:/scans/axe/exp8/norot5', 1, 10, 670, 619, 420:430, 'y', "per", 'axe', 1);
% plotAxePlay3('c:/scans/axe/exp8/norot5', 1, 10, 865, 846, 2107:2112, 'y', "per", 'axe2', 1);

% plotAxePlay3('c:/scans/axe/exp8/norot5', 1, 10, 1882, 1824, 260:270, 'x', "per", 'reference', 1);
% plotAxePlay3('c:/scans/axe/exp8/norot5', 1, 10, 884, 909, 1000:1010, 'x', "per", 'axe', 0);
% plotAxePlay3('c:/scans/axe/exp8/norot5', 1, 10, 1953, 1909, 1133:1143, 'x', "per", 'axe2', 1);

% EXP9 - urs X
% path = 'c:/scans/axe/exp9/norot';
%%% 0-1-360_2, 0-1-360_3 
% plotAxePlay3(path, 1, 20, 1882, 1824, 260:270, 'x', "per", 'reference', 1);
% plotAxePlay3(path, 1, 20, 1172, 1185, 950:960, 'x', "per", 'axe', 0);

% 
% plotAxePlay3(path, 1, 20, 1882, 1824, 260:270, 'x', "per", 'reference', 1);
% plotAxePlay3(path, 1, 20, 964, 1049, 810:820, 'x', "per", 'axe', 0);
% 
% plotAxePlay3(path, 1, 20, 409, 439, 2079:2089, 'y', "per", 'reference', 0);
% plotAxePlay3(path, 1, 20, 637, 583, 200:210, 'y', "per", 'axe', 1);
% 
% EXP10 - urs Y
%path = 'c:/scans/axe/exp10/lol3';
% plotAxePlay3(path, 1, 20, 1882, 1824, 260:270, 'x', "per", 'reference', 1);
% plotAxePlay3(path, 1, 20, 964, 1049, 810:820, 'x', "per", 'axe', 0);
% 
% plotAxePlay3(path, 1, 57, 409, 439, 2079:2089, 'y', "per", 'reference', 0);
% plotAxePlay3(path, 1, 57, 406, 370, 487:497, 'y', "per", 'axe', 1);

% plotAxePlay3(path, 1, 63, 8, 23, 1288:1298, 'y', "per", 'reference', 0);
% plotAxePlay3(path, 1, 63, 1200, 1182, 1273:1283, 'y', "per", 'axe', 1);

% EXP11 - 
% path = 'c:/scans/axe/exp11/norot8';
% itrs = 13;
% plotAxePlay3(path, 1, itrs, 317, 349, 2032:2042, 'y', "per", 'ref', 0);
% plotAxePlay3(path, 1, itrs, 14, 33, 342:362, 'y', "per", 'ref2', 0);
% plotAxePlay3(path, 1, itrs, 623, 590, 160:170, 'y', "per", 'axe_l', 1);
% plotAxePlay3(path, 1, itrs, 854, 843, 2000:2010, 'y', "per", 'axe_2', 1);


% 
% EXP12 - 
% path = 'c:/scans/axe/exp12/012_inited';
% itrs = 20;
% plotAxePlay3(path, 1, itrs, 317, 349, 2032:2042, 'y', "per", 'ref', 0);
% plotAxePlay3(path, 1, itrs, 14, 33, 342:362, 'y', "per", 'ref2', 0);
% plotAxePlay3(path, 1, itrs, 623, 590, 160:170, 'y', "per", 'axe_l', 1);
% plotAxePlay3(path, 1, itrs, 854, 843, 2000:2010, 'y', "per", 'axe_2', 1);
% path = 'c:/scans/axe/exp12/029_complex';
% itrs = 60;
% plotAxePlay3(path, 1, itrs, 317, 349, 2032:2042, 'y', "per", 'ref', 0);
% plotAxePlay3(path, 1, itrs, 14, 33, 332:342, 'y', "per", 'ref2', 0);
% plotAxePlay3(path, 1, itrs, 604, 568, 630:640, 'y', "per", 'axe_l', 1);
% 
% plotAxePlay3(path, 1, itrs, 1134, 1118, 120:130, 'x', "per", 'ref2', 1);
% plotAxePlay3(path, 1, itrs, 1447, 1490, 890:900, 'x', "per", 'axe_l', 0);

% 
% EXP13 - 
figure(1);
%path = 'c:/scans/axe/exp13/025';
%itrs = 51;
% plotAxePlay3(path, 1, itrs, 317, 349, 2032:2042, 'y', "per", 'ref', 0);
% plotAxePlay3(path, 1, itrs, 14, 33, 332:342, 'y', "per", 'ref2', 0);
% plotAxePlay3(path, 1, itrs, 567, 547, 590:600, 'y', "per", 'axe_l', 1);

% % 
% plotAxePlay3(path, 1, itrs, 488, 513, 9:15, 'x', "per", 'ref', 0);
% plotAxePlay3(path, 1, itrs, 1140, 113, 165:175, 'x', "per", 'ref2', 1);
% plotAxePlay3(path, 1, itrs, 75, 40, 1015:1025, 'x', "per", 'axe_l', 1);

path = 'c:/scans/axe/exp13/028';
itrs = 78;
% plotAxePlay3(path, 1, itrs, 320, 344, 2025:2035, 'y', "per", 'ref2', 0);
% plotAxePlay3(path, 1, itrs, 521, 504, 400:410, 'y', "per", 'axe_l', 1);
% 
plotAxePlay3(path, 1, itrs, 1142, 1121, 150:160, 'x', "per", 'ref2', 1);
plotAxePlay3(path, 1, itrs, 802, 819, 770:780, 'x', "per", 'axe_l', 0);

legend('show');

return;

%plotAxePlay2('/home/fna/scans/CsI/tomo/plastic2', 1, 1000, 1230, 250:258, 'x', "per", 'X tube drift', 1); hold on;
%plotAxePlay2('/home/fna/scans/CsI/tomo/plastic4', 1, 1000, 1226, 250:258, 'x', "per", 'X tube drift', 1); hold on;
%plotAxePlay2('/home/fna/scans/CsI/tomo/implant_without_grey', 1, 900, 2017, 250:258, 'x', "per", 'X tube drift', 1); hold on;
%plotAxePlay2('/home/fna/scans/CsI/tomo', 1, 100, 1232, 250:258, 'x', "per", 'X tube drift', 1); hold on;

%plotAxePlay2('/home/fna/scans/CsI/tomo/ok1', 1, 20, 2002, 494:500, 'x', "per", 'X tube drift', 1); hold on;
%plotAxePlay3('/home/fna/scans/CsI/tomo/ok1', 1, 20, 3884, 3518, 494:500, 'x', "per", 'X tube drift', 1); hold on;
plotAxePlay3('/home/fna/scans/CsI/tomo/plastic4_', 1, 830, 4826, 4641, 251:261, 'x', "per", 'X tube drift', 1); hold on;






% path = '/home/fna/scans/CsI/tomo/tomo3/1';
% plotAxePlay2(path, 360, 1, 2039, 1091:1096, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 360, 1, 2938, 2095:2095, 'x', "per", 'X axe'); hold on;

% path = '/home/fna/scans/CsI/tomo/1';
% plotAxePlay2(path, 360, 1, 2026, 1091:1096, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 360, 1, 3104, 2186:2192, 'x', "per", 'X axe'); hold on;

% grey tomo 900
% path = '/home/fna/scans/CsI/tomo';
% plotAxePlay2(path, 900, 1, 2026, 1091:1096, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 900, 1, 3023, 2186:2192, 'x', "per", 'X axe'); hold on;

% path = '/home/fna/scans/CsI/tomo/lol1';
% plotAxePlay2(path, 900, 1, 2026, 796:804, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 900, 1, 3138, 2186:2192, 'x', "per", 'X axe'); hold on;


% % 000_0-360
% path = '/home/fna/scans/CsI/axe/000_0-360';
% plotAxePlay2(path, 1, 30, 946, 600:606, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 1, 30, 3267, 2232:2238, 'x', "per", 'X axe'); hold on;
% title('~M18.8, 2.633 um, 0-360, itr time hz');
% set(gcf,'position',[100,100,600,450]); saveas(gcf,'/home/fna/piter/play/000_0-360.png'); close all;
% 
% % 0-1-360 no delay itr time: 89.12s
% path = '/home/fna/scans/CsI/axe/001_0-1-360';
% plotAxePlay2(path, 1, 30, 945, 600:606, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 1, 30, 3389, 2232:2238, 'x', "per", 'X axe'); hold on;
% title('~M18.8, 2.633 um, 0-1-360, no delay, itr time 89.12s');
% set(gcf,'position',[100,100,600,450]); saveas(gcf,'/home/fna/piter/play/001_0-1-360-no-delay-itr-89.12s.png'); close all;
% 
% % 0-1-360 2s itr time: 937 s
% path = '/home/fna/scans/CsI/axe/002-0-1-360_2sec';
% plotAxePlay2(path, 1, 2, 955, 600:606, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 1, 2, 3546, 2232:2238, 'x', "per", 'X axe'); hold on;
% title('~M18.8, 2.633 um, 0-1-360, delay 2s, itr time 937s');
% set(gcf,'position',[100,100,600,450]); saveas(gcf,'/home/fna/piter/play/002_0-1-360-delay-2s-itr-937s.png'); close all;
% 
% % 0-1-360 2s itr time: 937 s
% path = '/home/fna/scans/CsI/axe/003-0-1-360_2sec_noch';
% plotAxePlay2(path, 1, 3, 955, 600:606, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 1, 3, 3249, 2232:2238, 'x', "per", 'X axe'); hold on;
% title('~M18.8, 2.633 um, 0-1-360, delay 2s, itr time 937s');
% set(gcf,'position',[100,100,600,450]); saveas(gcf,'/home/fna/piter/play/003_0-1-360-delay-2s-itr-937s.png'); close all;
% % 0-1-360 5s itr time: 2000s
% path = '/home/fna/scans/CsI/axe/004-0-1-360_5sec';
% plotAxePlay2(path, 1, 4, 955, 600:606, 'x', "per", 'X tube drift', 1); hold on;
% plotAxePlay2(path, 1, 4, 3475, 2232:2238, 'x', "per", 'X axe'); hold on;
% title('~M18.8, 2.633 um, 0-1-360, delay 5s, itr time 2000s');
% set(gcf,'position',[100,100,600,450]); saveas(gcf,'/home/fna/piter/play/004_0-1-360-delay-5s-itr-2000s.png'); close all;





