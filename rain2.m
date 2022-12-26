
global colorIndex;

r = 2.*randn(1,1);
%r = randn(500, 1)
% [x] = histogram(r);
% 
% return;


calibPath = 'd:/scans/mp9';
points = [2 4];

tif = Tiff(sprintf('%s/offset.tif', calibPath), 'r');
dark = double(read(tif));
tif = Tiff(sprintf('%s/gain.tif', calibPath), 'r');
gain = double(read(tif));
[raw] = loadMetaImage('d:scans/rain9/12_10000_1/img_.mhd');

raw = raw(:, :, 1:10000);

% raw(543, :, :) = raw(542, :, :);
% raw(544, :, :) = raw(545, :, :);
% raw = raw(17:end, :, :);
% gain(:, 543) = gain(:, 542); dark(:, 543) = dark(:, 542);
% gain(:, 544) = gain(:, 545); dark(:, 544) = dark(:, 545);
% gain = gain(:, 17:end);
% dark = dark(:, 17:end);

%raw = 

% roi = squeeze(raw(:, 150, :))';
% imagesc(roi);


%% snr pixel
row = 150;
snrPix = zeros(size(raw,1), 1);
for c=1:size(raw,1)
    sel=double(squeeze(raw(c, row, 1:2998)));
    sel = sel - dark(row, c);
    snrPix(c) = mean(sel)/std(sel);
end
snrPix = mean(snrPix)


%% mean drift
avg = 100;

% sel = squeeze(raw(col, row, :)) - dark(row, col);
% sel = sel(1:numel(sel) - mod(numel(sel), avg));
% sel = reshape(sel, [avg numel(sel)/avg]);
% sel = sum(sel, 1);
% first = sel(1);
% plot(1:numel(sel), sel, '.-b', 'DisplayName', 'Pixel mean'); hold on;
% plot(1:numel(sel), (sel-first)/first * 100, '.-b', 'DisplayName', 'Pixel mean'); hold on;    

cols = 10:100;
rows = 10:100;
pointsNum = (size(raw, 3) - mod(size(raw, 3), avg)) / avg
means = zeros(numel(rows), numel(cols), pointsNum);

rowInd = 1;

for row=rows
    colInd = 1;
    for col=cols
        sel = squeeze(raw(col, row, :)) - dark(row, col);
        sel = sel(1:numel(sel) - mod(numel(sel), avg));
        sel = reshape(sel, [avg numel(sel)/avg]);
        sel = sum(sel, 1);
        first = sel(1);

        means(rowInd, colInd, :) = ((sel-first)/first * 100);
        colInd = colInd + 1;
    end
    
    rowInd = rowInd + 1;
end

colorIndex = 1;
colorInd = 1;
step = idivide(int32(pointsNum), 5);
for p=2:4:20
    [y, x] = histcounts(means(:, :, p));
    sum(y)
    plot(x(2:end), y, nextcolor(), 'DisplayName', sprintf('%d minutes', round((single(p)/pointsNum*116)))); hold on;
end    
legend('show');



%% SNR pixel-matrix

row = 150;
roi = squeeze(raw(:, row, :))';
imagesc(roi);
sinoAvg = round(sum(roi, 1) ./ size(roi, 1));
rr = double(sinoAvg-dark(row, :))./double(gain(row,:)-dark(row, :));

% for i=1:numel(rr)
%     rr(i) = rr(i) + (rr(i)/17.)*randn(1,1);
% end

x = 1:numel(rr);
[coeffs, y] = fito(1:numel(rr), rr, 'poly8');
%   plot(x, rr , '.-b'); hold on;
%   plot(x, y, '.-r'); hold on;
%   ylim([0 max(rr) * 1.1])
diff = rr - y';
snrMat = mean(rr)/std(diff)


avgs = 1:1:200;
col = 600;
snrPix = zeros(numel(avgs), 1);
snrPix2 = zeros(numel(avgs), 1);
snrPix3 = zeros(numel(avgs), 1);
ind = 1;
for avg=avgs
    sel = squeeze(raw(col, row, :)) - dark(row, col);
    sel = sel(1:numel(sel) - mod(numel(sel), avg));
    sel = reshape(sel, [avg numel(sel)/avg]);
    sel = sum(sel, 1);
    snrPix(ind) = mean(sel) / std(sel);
    
    sel = squeeze(raw(col+10, row, :)) - dark(row, col + 10);
    sel = sel(1:numel(sel) - mod(numel(sel), avg));
    sel = reshape(sel, [avg numel(sel)/avg]);
    sel = sum(sel, 1);
    snrPix2(ind) = mean(sel) / std(sel);    
    
    sel = squeeze(raw(col+20, row, :)) - dark(row, col + 20);
    sel = sel(1:numel(sel) - mod(numel(sel), avg));
    sel = reshape(sel, [avg numel(sel)/avg]);
    sel = sum(sel, 1);
    snrPix3(ind) = mean(sel) / std(sel); 
    
    ind = ind + 1;
end   

plot(avgs, snrPix, '.-b', 'DisplayName', 'Pixel SNR'); hold on;
plot(avgs, snrPix2, '.-k', 'DisplayName', 'Pixel SNR'); hold on;
plot(avgs, snrPix3, '.-g', 'DisplayName', 'Pixel SNR'); hold on;
plot(avgs, snrMat, '.-r', 'DisplayName', 'Pixel SNR'); hold on;


% 
%% sino integrals with diffrent avg

rows = 150;

avgs = 1999:2000:10000;

snrMat = zeros(numel(avgs), 1);
ind = 1;
for avg=avgs
    
    snrMat_ = zeros(numel(rows), 1);
    rowInd = 1;
    
    for i=rows
        roi = squeeze(raw(:, i, 1:avg))';
        
        sinoAvg = round(sum(roi, 1) ./ size(roi, 1));

        rr = double(sinoAvg-dark(i, :))./double(gain(i,:)-dark(i, :));

        %rr = rr - 0.02 + ind*0.01;
        %rr = rr(1:2537);
        x = 1:numel(rr);
        [coeffs, y] = fito(1:numel(rr), rr, 'poly8');

        plot(x, rr , '.-b'); hold on;
        plot(x, y, '.-r'); hold on;
        ylim([0 max(rr) * 1.1])

        diff = rr - y';

        snrMat_(rowInd) = mean(rr)/std(diff);
        rowInd = rowInd + 1;
    end
    
    snrMat(ind) = mean(snrMat_);
    ind = ind + 1;
end    

snrMat


%% max matrix snr


rows = 150;
%rows = rows + 601;

avgs = 1:100:10000

snrMat = zeros(numel(avgs), 1);
ind = 1;
for avg=avgs
    
    snrMat_ = zeros(numel(rows), 1);
    rowInd = 1;
    
    for i=rows
        roi = squeeze(raw(:, i, 1:avg))';
        
        sinoAvg = round(sum(roi, 1) ./ size(roi, 1));

        rr = double(sinoAvg-dark(i, :))./double(gain(i,:)-dark(i, :));
        
        %rr = rr - 0.03 + ind*0.01;
        x = 1:numel(rr);
        [coeffs, y] = fito(1:numel(rr), rr, 'poly8');

%         plot(x, rr , '.-b'); hold on;
%         plot(x, y, '.-r'); hold on;
%         ylim([0 max(rr) * 1.1])

        diff = rr - y';

        snrMat_(rowInd) = mean(rr)/std(diff);
        rowInd = rowInd + 1;
    end
    
    snrMat(ind) = mean(snrMat_);
    ind = ind + 1;
end    

plot(avgs, snrMat, '.-b');
snrMat


%% mp


row = 150;
m = zeros(numel(points), size(raw, 1));
rr = zeros(numel(points), size(raw, 1));

for p=1:numel(points)

    tif = Tiff(sprintf('%s/2000/gain-%04d.tif', calibPath, points(p)), 'r');
    img = read(tif);
    img = double(img(row, :));
    
%     img(:, 543) = img(:, 542);
%     img(:, 544) = img(:, 545);
%     img = img(:, 17:end);
   
    rr(p, :) = double(img-dark(row, :))./double(gain(row,:)-dark(row, :));
    
    [coeffs, y] = fito(1:size(raw, 1), rr(p, :), 'poly8');
    
% 
%         plot(x, rr , '.-b'); hold on;
%         plot(x, y, '.-r'); hold on;
%         ylim([0 max(rr) * 1.1])    
    
    m(p, :)  = y';
end

roi = squeeze(raw(:, row, :))';
img = round(sum(roi, 1) ./ size(roi, 1));
img = double(img-dark(row, :))./double(gain(row,:)-dark(row, :));

uncorr = 0;

for x=1:size(raw, 1)
    for p=1:numel(points)
        if (img(x) > rr(p, x))
            if (p == 1)
                p1_pixel = 1;
                p1_corr = 1;
            else
                p1_pixel = rr(p-1, x);
                p1_corr = m(p-1, x);
            end
            p2_pixel = rr(p, x);
            p2_corr = m(p, x);


            % ln
%                 p1_pixel = log(1.1/p1_pixel);
%                 p1_corr = log(1.1/p1_corr);
%                 p2_pixel = log(1.1/p2_pixel);
%                 p2_corr = log(1.1/p2_corr);
%                 img(x) = log(1.1/img(x));
%                 f = (img(x) - p1_pixel) / (p2_pixel - p1_pixel);
%                 val_corr = p1_corr + f * (p2_corr - p1_corr);
%                 
%                 img(x) = 1.1/exp(val_corr);
% 
%                 break;

                 f = (p1_pixel - img(x)) / (p1_pixel - p2_pixel);
                 val_corr = p1_corr - f * (p1_corr - p2_corr);
                 img(x) = val_corr;

            break;
        end

      if (p == numel(points))
            %ME = MException('MyComponent:noSuchVariable', ...
            %'Value is less than with the filter with maximum thickness');
            %throw(ME)

             x
             y
             img(x)
             projIdx
             %return;
%                 
          uncorr = uncorr + 1;
      end

    end
 
end    

uncorr

%img = img + 0.04;
%img = img(1:2537);

[coeffs, y] = fito(1:numel(img), img, 'poly8');
diff = img - y';
mean(img)/std(diff)

% 

x = 1:numel(img);
plot(x, img , '.-b'); hold on;
plot(x, y, '.-r'); hold on;
ylim([0 max(img) * 1.1])


