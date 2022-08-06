% 
centralY = 546;
spanY = 31;
dmpffcStep = 300;
points = [7, 12, 13];
path = 'd:/scans/schlum-teledyne/dmpffc2';
calibPath = 'd:/scans/DMPFFC'


[raw, spacing] = loadMetaImage(sprintf('%s/img_.mhd', path));
roi = raw(:, centralY-spanY:centralY+(spanY-1), :);
%imagesc(squeeze(roi(:, :, 10))');


ffcIdxPrev = -1

tif = Tiff(sprintf('%s/offset.tif', calibPath), 'r');
dark = read(tif);
dark = dark(centralY-spanY:centralY+(spanY-1), :);

uncorr = 0;


for projIdx=0:size(roi, 3)-1
    ffcIdx = idivide(int32(projIdx), dmpffcStep);
    
    if (ffcIdx ~= ffcIdxPrev)
        
        tif = Tiff(sprintf('%s/dmpgain-%04d-%04d.tif', calibPath, ffcIdx+1, 0), 'r');
        gain = read(tif);
        gain = gain(centralY-spanY:centralY+(spanY-1), :);
        
        for p=1:numel(points)
            
            tif = Tiff(sprintf('%s/dmpgain-%04d-%04d.tif', calibPath, ffcIdx+1, points(p)), 'r');
            img = read(tif);
            img = img(centralY-spanY:centralY+(spanY-1), :);
            
            rr(:, :, p) = double(img-dark)./double(gain-dark);
            
            for y=1:spanY*2
                [coeffs, fitY] = fito(1:size(rr, 2), rr(y, :, p), 'poly8');
                m(y, :, p) = fitY;
            end
        end
        
        ffcIdxPrev = ffcIdx;
        
    end
    
    img = roi(:, :, projIdx+1)';
    img = double((img - dark).*1) ./ double(gain - dark);

    tifCorr = zeros(size(rr, 1), size(rr, 2), 'uint16');
    %tifCorr = round(65535./(1.2./img));
    %tifCorr = uint16(tifCorr);
    
    for x=1:size(rr, 2)
        for y=1:size(rr, 1)
            corr = 0;
            for p=1:numel(points)
                if (img(y, x) > rr(y, x, p))
                    if (p == 1)
                        p1_pixel = 1;
                        p1_corr = 1;
                    else
                        p1_pixel = rr(y, x, p-1);
                        p1_corr = m(y, x, p-1);
                    end
                    p2_pixel = rr(y, x, p);
                    p2_corr = m(y, x, p);


                    % ln
                    p1_pixel = log(1.1/p1_pixel);
                    p1_corr = log(1.1/p1_corr);
                    p2_pixel = log(1.1/p2_pixel);
                    p2_corr = log(1.1/p2_corr);
                    img(y, x) = log(1.1/img(y, x));
                    f = (img(y, x) - p1_pixel) / (p2_pixel - p1_pixel);
                    val_corr = p1_corr + f * (p2_corr - p1_corr);
                    tifCorr(y, x) = round(65535/exp(val_corr));
    % 
    %                 break;
    
%                     f = (p1_pixel - img(y, x)) / (p1_pixel - p2_pixel);
%                     val_corr = p1_corr - f * (p1_corr - p2_corr);
%                     tifCorr(y, x) = round(65535/(1.1/val_corr));

                    break;
                end

              if (p == numel(points))
                    %ME = MException('MyComponent:noSuchVariable', ...
                    %'Value is less than with the filter with maximum thickness');
                    %throw(ME)

                     x
                     y
                     img(y, x)
                     projIdx
                     %return;
        %                 
                  tifCorr(y, x) = round(65535/(1.1/img(y, x)));
                  uncorr = uncorr + 1;
              end

            end
        end        
    end    


%uncorr

    t = Tiff(sprintf('%s/corr/img_%04d.tif', path, projIdx), 'w');
    %t = Tiff(sprintf('%s/r.tif', path), 'w');
    tagstruct.ImageLength = size(tifCorr,1);
    tagstruct.ImageWidth = size(tifCorr,2);
    tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
    tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
    tagstruct.BitsPerSample = 16;
    tagstruct.SamplesPerPixel = 1;
    tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
    setTag(t,'ResolutionUnit',Tiff.ResolutionUnit.Inch);
    setTag(t,'XResolution', 25.4/spacing(1));
    setTag(t,'YResolution', 25.4/spacing(1));
    tagstruct.Software = 'MATLAB'; 
    setTag(t,tagstruct);
    write(t,tifCorr);
    close(t);        

    projIdx
    
    
        
end

uncorr

return;




% % 
% % %centralX = 1473;
% % centralX = 2945;
% % spanX = 2944;
% % % 
path = 'd:/scans/mp3/1000';

t = Tiff(sprintf('%s/gain-0000.tif', path), 'r');
gain = read(t);
t = Tiff(sprintf('%s/offset.tif', path), 'r');
dark = read(t);
% % 
% % % 
% % % 
% thicks = { 'B1-gain-al01', 'B1-gain-al02', 'B1-gain-al03', 'B1-gain-al04', 'B1-gain-al05', 'B1-gain-al06', 'B1-gain-al07', 'B1-gain-al08', 'B1-gain-al09' };
%            %'B1-gain-al10', 'B1-gain-al11' };
% thicks = { 'gain-0001', 'gain-0002', 'gain-0003', 'gain-0004', 'gain-0005', 'gain-0006', 'gain-0007', 'gain-0008', 'gain-0009', 'gain-0010', 'gain-0011', 'gain-0012', 'gain-0013', ...
%     'gain-0014', 'gain-0015', 'gain-0016', 'gain-0017', 'gain-0018', 'gain-0019', 'gain-0020', 'gain-0021', 'gain-0022', 'gain-0023', 'gain-0024', 'gain-0025', ...
%     'gain-0026', 'gain-0027', 'gain-0028', 'gain-0029', 'gain-0030', 'gain-0031', 'gain-0032', 'gain-0033', 'gain-0034', 'gain-0035', 'gain-0036', 'gain-0036', ...
%     'gain-0037', 'gain-0038', 'gain-0039', 'gain-0040', 'gain-0041', 'gain-0042', 'gain-0043', 'gain-0044', 'gain-0045', 'gain-0046', 'gain-0047', 'gain-0048', ...
%     'gain-0049', 'gain-0050', 'gain-0051', 'gain-0052'};
%thicks = { 'gain-0001', 'gain-0002', 'gain-0003', 'gain-0004', 'gain-0005', 'gain-0006', 'gain-0007','gain-0008', 'gain-0009', 'gain-0010', 'gain-0011', 'gain-0013' };
thicks = {  'gain-0007', 'gain-0013' };
%thicks2 = {  'gain-0011_3', 'gain-0013_3' };

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
    
    %tif2 = Tiff(sprintf('%s/%s.tif', path, char(thicks2(t))), 'r');
    %img2 = double(read(tif));    
    %img = (img + img2) ./ 2;
    
    r = (img-double(dark))./double(gain-dark);
    rr(:, :, t) = r(centralY-spanY:centralY+(spanY-1), :);
     
    for y=1:spanY*2
        
        [coeffs, y] = fito(1:size(rr, 2), rr(y, :, t), 'poly8');

        
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
        m(y, :, t) = gyk;
        
        %m(y, :, t) = mean(gyk); % curr
        
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



path = 'd:/scans/rain/al1_mp3/tiffs';

uncorr = 0;

proj = 0;
for proj=0:299
%proj = -100;

tif = Tiff(sprintf('%s/img4__%04d.tif', path, proj), 'r');
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

t = Tiff(sprintf('%s/corr/img_%04d.tif', path, proj), 'w');
%t = Tiff(sprintf('%s/r.tif', path), 'w');
tagstruct.ImageLength = size(tifCorr,1);
tagstruct.ImageWidth = size(tifCorr,2);
tagstruct.SampleFormat = Tiff.SampleFormat.UInt;
tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
tagstruct.BitsPerSample = 16;
tagstruct.SamplesPerPixel = 1;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
setTag(t,'ResolutionUnit',Tiff.ResolutionUnit.Inch);
setTag(t,'XResolution',298.82);
setTag(t,'YResolution',298.82);
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


