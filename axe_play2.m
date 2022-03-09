

%t = Tiff('/home/fna/scans/kern30/ffc/al-23mm.tif', 'r');
t = Tiff('/home/fna/scans/kern30/releases/8583/img_0227.tif', 'r');
img = read(t);
img = double((img - dark).*1) ./ double(gain - dark);

%img(1822, 3658)

imagesc(img);

profile2 = img(1822, :);

%min(img(1822, 300:4000))

plot(1:numel(profile2), profile2, '.-r'); hold on;



t = Tiff('/home/fna/scans/kern30/ffc/al-28mm.tif', 'r');
img = read(t);
img = double((img - dark).*1) ./ double(gain - dark);
profile = img(1822, :);

%img(1822, 3658)

[xData, yData] = prepareCurveData( 1:numel(profile), profile );
ft = fittype( 'sin1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 0 -Inf];
opts.StartPoint = [0.207400238446752 0.000533649168267334 -0.0261106105938564];
[fitresult, gof] = fit( xData, yData, ft, opts );
% 
gyk = zeros(numel(profile), 1);
for i=1:numel(profile)
    gyk(i) = feval(fitresult, i);
end
plot(1:numel(profile), profile, '.-r'); hold on;
plot(1:numel(profile), gyk, '.-b'); hold on;


%imagesc(img);


%min(img(1822, 300:4000))

plot(1:numel(profile), profile, '.-b'); hold on;

x = 1:numel(profile);

return;

gyk = zeros(200, 1);

for i=0:199
    t = Tiff(sprintf('/home/fna/scans/gap/img_%04d.tif', i), 'r');
    img = double(read(t));
    
    profile = img(2165, 2915:2974);
    
    for p=numel(profile):-1:1
        if (profile(p) <= 9632)
            r = p + 2914;
            break;
        end
    end    
    
    gyk(i+1) = r;
    %imagesc(img);
    
    %return;
    
end

plot(1:numel(gyk), gyk, '.-b');
% 
% 
% % 
% figure(1);
i = 1;
t = Tiff(sprintf('/home/fna/scans/gap/img_%04d.tif', i), 'r');
img = double(read(t));
imagesc(img);
% 
% 
% profile = img(1720, 2867:2974);
% for p=numel(profile):-1:1
%     if (profile(p) <= 8628)
%         r = p + 2866;
%     end
% end


return;
% % 
%t = Tiff('/home/fna/scans/GOS/VC-FFC/implants/img_0000.tif', 'r');
% t = Tiff('/home/fna/scans/GOS/VC-FFC/ffc/al-9mm.tif', 'r');
% img = double(read(t));
% imagesc(img(1900:1910, :));
% 
% min(min(img(1900:1910, :)))
% 
% % 
% % r = reshape(img, [numel(img), 1]);
% % std(r)/mean(r)
% 
% return;

%%
% t = Tiff('/home/fna/scans/GOS/cyl2/ffc/gain.tif', 'r');
% img1 = double(read(t));
% %imagesc(img1)
% 
% t = Tiff('/home/fna/scans/GOS/cyl2/ffc/gain_2.tif', 'r');
% img2 = double(read(t));
% % imagesc(img1)
% 
% r = img1./img2;
% r = r(1700:1900, :);
% r = reshape(r, [numel(r), 1]);


%imagesc(r);
% 
% 
% 
% t = Tiff('/home/fna/scans/GOS/cyl2/ffc/al-4mm.tif', 'r');
% img1 = double(read(t)) - double(dark);
% %imagesc(img1)
% 
% t = Tiff('/home/fna/scans/GOS/cyl2/ffc/al-4mm_0.5I.tif', 'r');
% img2 = (double(read(t)) - double(dark)) .*2;
% % imagesc(img1)
% 
% r = img1./img2;
% r = r(1700:1900, :);
% r = reshape(r, [numel(r), 1]);
% 
% imagesc(r)
% 
% 
% 
% return;

t = Tiff('/home/fna/scans/GOS/cyl2/ffc/gain.tif', 'r');
gain = read(t);
t = Tiff('/home/fna/scans/GOS/cyl2/ffc/offset.tif', 'r');
dark = read(t);

% t = Tiff('/home/fna/scans/GOS/cyl2/ffc/al-4mm.tif', 'r');
% img = read(t);
% 
% 
% r = double((img - dark).*1) ./ double(gain - dark);
% r = r(1500:1700, 2104:2304);
% imagesc(r);
% r1 = reshape(r, [numel(r), 1]);
% std(r1)/mean(r1)

%r = reshape(r, [numel(r), 1]);
%imagesc(r);

% 
thicks = { 'al-2mm', 'al-4mm', 'al-7mm', 'al-9mm' };
rr = zeros(3, 2944, numel(thicks));

for t=1:numel(thicks)
   
    tif = Tiff(sprintf('/home/fna/scans/GOS/cyl2/ffc/%s.tif', char(thicks(t))), 'r');
    img = read(tif);
    
     r = double((img - dark).*1) ./ double(gain - dark);
     rr(:, :, t) = r(1800:1802, :);
    
    
    %r = r(1700:1900, :);
        
    
end
% 
% plot(1:numel(thicks), squeeze(rr(1, 87, :)), '.-b'); hold on;
% plot(1:numel(thicks), squeeze(rr(1, 112, :)), '.-r'); hold on;
% 
% return;

for proj=0:599
%proj = -100;

tif = Tiff(sprintf('/home/fna/scans/GOS/cyl2/img_%04d.tif', proj), 'r');
%tif = Tiff('/home/fna/scans/GOS/cyl2/ffc/al-5mm.tif', 'r');
img = read(tif);
img = double((img - dark).*1) ./ double(gain - dark);
img = img(1800:1802, :);

m = zeros(numel(thicks), 1);
for t=1:numel(thicks)
    m(t) = mean(reshape(rr(:, :, t), [numel(rr(:, :, t)) 1]));
end

tifCorr = zeros(size(rr, 1), size(rr, 2), 'uint16');

for x=1:size(rr, 2)
    for y=1:size(rr, 1)
        corr = 0;
        for t=1:numel(thicks)
            if (img(y, x) > rr(y, x, t))
                if (t == 1)
                    p1_pixel = 1;
                    p1_corr = 1;
                else
                    p1_pixel = rr(y, x, t-1);
                    p1_corr = m(t-1);
                end
                p2_pixel = rr(y, x, t);
                p2_corr = m(t);

                f = (p1_pixel - img(y, x)) / (p1_pixel - p2_pixel);
                
                val_corr = p1_corr - f * (p1_corr - p2_corr);
                %val_corr = img(y, x);
                tifCorr(y, x) = round(65535/(1.1/val_corr));

                break;
            end
    
            if (t == numel(thicks))
                ME = MException('MyComponent:noSuchVariable', ...
                'Value is less than with the filter with maximum thickness');
                throw(ME)
            end

        end
    end        
end    
% 
path = '/home/fna/scans/GOS/cyl2/corr2';
t = Tiff(sprintf('%s/img_%04d.tif', path, proj), 'w');
tagstruct.ImageLength = size(tifCorr,1);
tagstruct.ImageWidth = size(tifCorr,2);
tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
tagstruct.BitsPerSample = 16;
tagstruct.SamplesPerPixel = 1;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.Software = 'MATLAB'; 
setTag(t,tagstruct);
write(t,tifCorr);
close(t);    

end

%         if (t == 1)
%             f = rr(y, x, 1)/m(1);
%             corr = f*(1-val)/(1-rr(y, x, 1));
%         end
%             
%         if (t > 1)
%             base = m(t-1);
%             f = m(t-1)/
%         end


return;


figure(2);
path = '/home/fna/scans/GOS/implantsB1';
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





