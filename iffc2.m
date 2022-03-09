

% img = read(Tiff('/home/fna/scans/GOS/char/tomo/IFFC/beton/corr/img_0000.tif', 'r'));
% img = double(img);
% r1 = reshape(img, [numel(img) 1]);
% std(r1)/mean(r1)
% 
% 
% return;

%img = read(Tiff('/home/fna/scans/GOS/char/tomo/IFFC/cyl/img_0000.tif', 'r'));
% img = read(Tiff('/home/fna/scans/GOS/char/tomo/IFFC/ffc/al-9mm.tif', 'r'));
% imagesc(img);
% roi = zeros(size(img, 1), size(img, 2), 'logical');
% roi(1782:1784, :) = 1;
% % 
% 
% flip(sort(img(roi)))
% 
% %min(img(roi))
% 
% 
% 
% return;

% [raw] = loadMetaImage('/home/fna/scans/GOS/char/tomo/IFFC/beton/V/slice.mha');
% imagesc(raw);
% r = raw(971:1070, 2175:2256);
% r = reshape(r, [numel(r), 1]);
% mean(r)
% std(r)
% 
% [raw] = loadMetaImage('/home/fna/scans/GOS/char/tomo/IFFC/beton/corr/V/slice.mha');
% imagesc(raw);
% r = raw(971:1070, 2175:2256);
% r = reshape(r, [numel(r), 1]);
% mean(r)
% std(r)
% 
% 
% return;

% img = read(Tiff(sprintf('%s/ffc/al-5mm.tif', path), 'r'));
% % 
% % 
% r = double((img - dark).*1) ./ double(gain - dark);
% r = r(1804-50:1804+49, :);
% %imagesc(r);
% r1 = reshape(r, [numel(r), 1]);
% std(r1)/mean(r1)

centralY = 1824;
spanY = 2;

%centralX = 1473;
centralX = 2945;
spanX = 2944;

path = '/home/fna/scans/kern30/releases/8583';

t = Tiff(sprintf('%s/ffc/gain.tif', path), 'r');
gain = read(t);
t = Tiff(sprintf('%s/ffc/offset.tif', path), 'r');
dark = read(t);


thicks = { 'al-1mm', 'al-2mm', 'al-3mm', 'al-4mm', 'al-5mm', 'al-6mm', 'al-7mm', 'al-8mm', 'al-9mm', 'al-10mm', ...
           'al-11mm', 'al-12mm', 'al-13mm', 'al-14mm', 'al-15mm', 'al-16mm', 'al-17mm', 'al-18mm', 'al-19mm', 'al-20mm', ...
           'al-21mm', 'al-22mm', 'al-23mm', 'al-24mm', 'al-25mm', 'al-26mm', 'al-27mm', 'al-28mm' };
rr = zeros(spanY*2, spanX*2, numel(thicks));
m = zeros(spanY*2, spanX*2, numel(thicks));

for t=1:numel(thicks)
   
    tif = Tiff(sprintf('%s/ffc/%s.tif', path, char(thicks(t))), 'r');
    img = read(tif);
    
     r = double((img - dark).*1) ./ double(gain - dark);
     rr(:, :, t) = r(centralY-spanY:centralY+(spanY-1), centralX-spanX:centralX+(spanX-1));
     
    for y=1:spanY*2
        profile = rr(y, :, t);
        [xData, yData] = prepareCurveData( 1:numel(profile), profile );
%         ft = fittype( 'sin1' );
%         opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
%         opts.Display = 'Off';
%        opts.Lower = [-Inf 0 -Inf];
%        opts.StartPoint = [0.207400238446752 0.000533649168267334 -0.0261106105938564];


        ft = fittype( 'poly9' );
        opts = fitoptions( 'Method', 'LinearLeastSquares' );
        opts.Robust = 'Bisquare';
        
        
        [fitresult, gof] = fit( xData, yData, ft, opts );     
        
        gyk = zeros(numel(profile), 1);
        for i=1:numel(profile)
            gyk(i) = feval(fitresult, i);
        end
        m(y, :, t) = gyk;
        
%         if (y == 2)
%             plot(1:numel(profile), profile, char(colors(y+1))); hold on;
%             plot(1:numel(profile), gyk, char(colors(y))); hold on;
%         end
    
    end
    
    %break;
    
end

%return;
% 
% % 
% plot(1:numel(thicks), squeeze(rr(1, 250, :)), '.-k'); hold on;
% plot(1:numel(thicks), squeeze(rr(1, 251, :)), '.-k'); hold on;
% plot(1:numel(thicks), squeeze(rr(1, 2438, :)), '.-r'); hold on;
% plot(1:numel(thicks), squeeze(rr(1, 2440, :)), '.-r'); hold on;
% plot(1:numel(thicks), squeeze(rr(1, 2442, :)), '.-r'); hold on;
% plot(1:numel(thicks), squeeze(rr(1, 1400, :)), '.-b'); hold on;
% plot(1:numel(thicks), squeeze(rr(1, 1401, :)), '.-b'); hold on;
% s = sum(rr(:, :, 6), 1);
% plot(1:spanX*2, s, '.-b'); hold on;

% 





uncorr = 0;

proj = 0;
for proj=0:719
%proj = -100;

tif = Tiff(sprintf('%s/img_%04d.tif', path, proj), 'r');
%tif = Tiff(sprintf('%s/ffc/al-5mm.tif', path), 'r');
img = read(tif);
img = double((img - dark).*1) ./ double(gain - dark);
img = img(centralY-spanY:centralY+(spanY-1), centralX-spanX:centralX+(spanX-1));

% m = zeros(numel(thicks), 1);
% for t=1:numel(thicks)
%     m(t) = mean(reshape(rr(:, :, t), [numel(rr(:, :, t)) 1]));
% end



tifCorr = zeros(size(rr, 1), size(rr, 2), 'uint16');

around = 10;


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
                    
                    p1_corr = m(y, x, t-1);
                    %p1_corr = mean(mean(rr(max(y-around, 1):min(y+around, size(rr, 1)), max(x-around, 1):min(x+around, size(rr, 2)), t - 1)));
                end
                p2_pixel = rr(y, x, t);
                p2_corr = m(y, x, t);
                %p2_corr = mean(mean(rr(max(y-around, 1):min(y+around, size(rr, 1)), max(x-around, 1):min(x+around, size(rr, 2)), t)));

                f = (p1_pixel - img(y, x)) / (p1_pixel - p2_pixel);
                
                val_corr = p1_corr - f * (p1_corr - p2_corr);
                %val_corr = img(y, x);
                tifCorr(y, x) = round(65535/(1.1/val_corr));

                break;
            end
    
            if (t == numel(thicks))
                %ME = MException('MyComponent:noSuchVariable', ...
                %'Value is less than with the filter with maximum thickness');
                %throw(ME)
                
                 x
                 y
                 img(y, x)
                 proj
                 return;
%                 
                tifCorr(y, x) = round(65535/(1.1/img(y, x)));
                uncorr = uncorr + 1;
            end

        end
    end        
end    
% 

%uncorr

t = Tiff(sprintf('%s/corr3/img_%04d.tif', path, proj), 'w');
%t = Tiff(sprintf('%s/r.tif', path), 'w');
tagstruct.ImageLength = size(tifCorr,1);
tagstruct.ImageWidth = size(tifCorr,2);
tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
tagstruct.BitsPerSample = 16;
tagstruct.SamplesPerPixel = 1;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
setTag(t,'ResolutionUnit',Tiff.ResolutionUnit.Inch);
setTag(t,'XResolution',513.13);
setTag(t,'YResolution',513.13);
tagstruct.Software = 'MATLAB'; 
setTag(t,tagstruct);
write(t,tifCorr);
close(t);    


% t = Tiff('/home/fna/scans/GOS/IFFC/r.tif', 'r');
% t = Tiff('/home/fna/scans/GOS/IFFC/r.tif', 'r');
% img = double(read(t));
% 
% r = reshape(img, [numel(img), 1]);
% std(r)/mean(r)
end

uncorr


