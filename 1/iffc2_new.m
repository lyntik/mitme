

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

centralY = 561;
spanY = 5;
% % 
% % %centralX = 1473;
% % centralX = 2945;
% % spanX = 2944;
% % % 
path = 'c:/scans/MP/ffc-curr';
% 
t = Tiff(sprintf('%s/B1-gain.tif', path), 'r');
gain = read(t);
t = Tiff(sprintf('%s/B1-offset.tif', path), 'r');
dark = read(t);
% % 
% % % 
% % % 
% thicks = { 'B1-gain-al01', 'B1-gain-al02', 'B1-gain-al03', 'B1-gain-al04', 'B1-gain-al05', 'B1-gain-al06', 'B1-gain-al07', 'B1-gain-al08', 'B1-gain-al09' };
%            %'B1-gain-al10', 'B1-gain-al11' };
thicks = { 'B1-gain-curr50', 'B1-gain-curr46', 'B1-gain-curr42', 'B1-gain-curr38', 'B1-gain-curr34', 'B1-gain-curr30', 'B1-gain-curr26', 'B1-gain-curr22', ...
           'B1-gain-curr18', 'B1-gain-curr14', 'B1-gain-curr10'};
% rr = zeros(spanY*2, size(dark, 2), numel(thicks));
% m = zeros(spanY*2, size(dark, 2), numel(thicks));
% 
% 
% % tif = Tiff(sprintf('%s/%s.tif', path, char(thicks(1))), 'r');
% % img = read(tif);
% % 
% % tif = Tiff(sprintf('%s/%s.tif', path, char(thicks(2))), 'r');
% % img2 = read(tif);
% % 
% % imagesc(img)
% % 
% % return;


for t=1:numel(thicks)
   
    tif = Tiff(sprintf('%s/%s.tif', path, char(thicks(t))), 'r');
    img = double(read(tif));
    
    r = (img-double(dark))./double(gain-dark);
    rr(:, :, t) = r(centralY-spanY:centralY+(spanY-1), :);
     
    for y=1:spanY*2
        profile = rr(y, :, t);
        [xData, yData] = prepareCurveData( 1:numel(profile), profile );

        %plot(1:numel(profile), profile, '.-b');

        %return;
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
        %m(y, :, t) = gyk;
        
        m(y, :, t) = mean(gyk); % curr
        
%         
%          if (y == 2)
%              plot(1:numel(profile), profile, '.-b'); hold on;
%              plot(1:numel(profile), gyk, '.-r'); hold on;
%              return;
%          end
    
    end

    t
    
    %break;
    
end
% 


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



path = 'c:/scans/MP/beton2/tifs';

uncorr = 0;

proj = 0;
for proj=0:899
%proj = -100;

tif = Tiff(sprintf('%s/img__%04d.tif', path, proj), 'r');
%tif = Tiff(sprintf('%s/ffc/al-5mm.tif', path), 'r');
img = read(tif);
img = double((img - dark).*1) ./ double(gain - dark);
img = img(centralY-spanY:centralY+(spanY-1), :);

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


                % ln
%                 p1_pixel = log(1.1/p1_pixel);
%                 p1_corr = log(1.1/p1_corr);
%                 p2_pixel = log(1.1/p2_pixel);
%                 p2_corr = log(1.1/p2_corr);
%                 img(y, x) = log(1.1/img(y, x));
%                 f = (img(y, x) - p1_pixel) / (p2_pixel - p1_pixel);
%                 val_corr = p1_corr + f * (p2_corr - p1_corr);
%                 tifCorr(y, x) = round(65535/exp(val_corr));
% 
%                 break;

                %p2_corr = mean(mean(rr(max(y-around, 1):min(y+around, size(rr, 1)), max(x-around, 1):min(x+around, size(rr, 2)), t)));
                f = (p1_pixel - img(y, x)) / (p1_pixel - p2_pixel);
                val_corr = p1_corr - f * (p1_corr - p2_corr);
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
                 %return;
%                 
                tifCorr(y, x) = round(65535/(1.1/img(y, x)));
                uncorr = uncorr + 1;
            end

        end
    end        
end    
% 

%uncorr

t = Tiff(sprintf('%s/corr-curr/img_%04d.tif', path, proj), 'w');
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


