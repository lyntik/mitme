% 
onepospath = '/home/fna/scans/detchar/b2';
shots = 1000;
slicepath = '/m2/V/char/teledyne-disc-100-40.mha';

% teledyne
% roiX1 = 1;
% roiX2 = 2304;
% roiY1 = 650;
% roiY2 = 750;
% 
% center = 1176;
% between = 1094;
% left = 971;
% noobj = 650;
% 
% sliceX1 = 1050;
% sliceX2 = 1150;
% sliceY1 = 1050;
% sliceY2 = 1150;
% 
% crosstalkX1 = 330;
% crosstalkX2 = 430;
% crosstalkY1 = 1;
% crosstalkY2 = 100;

% % ximea
% roiX1 = 1;
% roiX2 = 5056;
% roiY1 = 1;
% roiY2 = 232;
% 
% center = 2220;
% between = 1587;
% left = 825;
% noobj = 3700;
% 
% sliceX1 = 1900;
% sliceX2 = 2000;
% sliceY1 = 1900;
% sliceY2 = 2000;
% 
% crosstalkX1 = 3700;
% crosstalkX2 = 3800;
% crosstalkY1 = 1;
% crosstalkY2 = 232;
% 
roiX1 = 977;
roiX2 = 990;
roiY1 = 356;
roiY2 = 559;

center = 1;
between = 1587;
left = 825;
noobj = 3700;

sliceX1 = 1900;
sliceX2 = 2000;
sliceY1 = 1900;
sliceY2 = 2000;

crosstalkX1 = 2000;
crosstalkX2 = 2100;
crosstalkY1 = 1;
crosstalkY2 = 101;

% 
% %% read
[d_raw] = loadOnePosShots(onepospath, 1, shots, roiX1, roiX2, roiY1, roiY2);
% imagesc(d_raw(:, :, 1));

slice = loadMetaImage(slicepath);
imagesc(slice)

%% means, std pix, std ffc, std final, ln

means = zeros(size(d_raw, 1), size(d_raw, 2));
stds = zeros(size(d_raw, 1), size(d_raw, 2));
perc = zeros(size(d_raw, 1), size(d_raw, 2));
r = zeros(size(d_raw, 1), size(d_raw, 2));
rdev = zeros(size(d_raw, 1), size(d_raw, 2));

fprintf('Calc STD...\n');

n1 = (size(d_raw, 1));
n2 = (size(d_raw, 2));
parfor y=1:n1
    for x=1:n2
     
        s=permute(d_raw(y, x, :), [3 2 1]);
        
        d = std(s);
        m = mean(s);
        means(y, x) = m;
        stds(y, x) = d / sqrt(m);
        perc(y, x) = d / m;
        %r(y, x) = (m/g(y,x));
        r(y, x) = (m);
        
    end
end
% 
% fprintf('Calc ln STD...\n');
% 
% max_ = max(max(r)) + 0.001;
% 
% percln = zeros(size(d_raw, 1), size(d_raw, 2));
% li = zeros(size(d_raw, 1), size(d_raw, 2));
% lid = zeros(size(d_raw, 1), size(d_raw, 2));
% parfor y=1:n1
%     for x=1:n2
%         s=permute(d_raw(y, x, :), [3 2 1]);
%         
%         d = std(s);
%         m = mean(s);        
%         
%         li(y, x) = log(max_/(m/g(y,x)));
%         lid = log(max_/((m-d)/g(y,x))) - li(y,x);
%         percln(y, x) = lid/li(y,x);
%         if (percln(y, x) > 1) 
%             percln(y, x) = 1;
%         end
%     end
% end


d_raw1 = d_raw(:, :, 1);
d_raw2 = d_raw(:, :, 2);
d_raw3 = d_raw(:, :, 3);

ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
ind(:, center:center+13) = 1;
fprintf('[Center] Mean: %.4f (%.0f) STDF: %.4f STD%%: pix - %.4f (SNR %.4f), ffc only - %.4f, final - %.4f (real - %.4f %.4f %.4f)\n', mean(r(ind)), mean(means(ind)), mean(stds(ind)), mean(perc(ind)), 1/mean(perc(ind)), std(r(ind))/mean(r(ind)), sqrt(mean(perc(ind))^2+(std(r(ind))/mean(r(ind)))^2), std(d_raw1(ind) / mean(d_raw1(ind))), std(d_raw2(ind) / mean(d_raw2(ind))), std(d_raw3(ind) / mean(d_raw3(ind))));
return;
% 
% ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
% ind(:, between:between+3) = 1;
% fprintf('[Between] Mean: %.4f (%.0f) STDF: %.4f STD%%: pix - %.4f (SNR %.4f), ffc only - %.4f, final - %.4f (real - %.4f %.4f %.4f)\n', mean(r(ind)), mean(means(ind)), mean(stds(ind)), mean(perc(ind)), 1/mean(perc(ind)), std(r(ind))/mean(r(ind)), sqrt(mean(perc(ind))^2+(std(r(ind))/mean(r(ind)))^2), std(d_raw1(ind) / mean(d_raw1(ind))), std(d_raw2(ind) / mean(d_raw2(ind))), std(d_raw3(ind) / mean(d_raw3(ind))));
% 
% ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
% ind(:, left:left+3) = 1;
% fprintf('[Left] Mean: %.4f (%.0f) STDF: %.4f STD%%: pix - %.4f (SNR %.4f), ffc only - %.4f, final - %.4f (real - %.4f %.4f %.4f)\n', mean(r(ind)), mean(means(ind)), mean(stds(ind)), mean(perc(ind)), 1/mean(perc(ind)), std(r(ind))/mean(r(ind)), sqrt(mean(perc(ind))^2+(std(r(ind))/mean(r(ind)))^2), std(d_raw1(ind) / mean(d_raw1(ind))), std(d_raw2(ind) / mean(d_raw2(ind))), std(d_raw3(ind) / mean(d_raw3(ind))));
% 
% ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
% ind(:, noobj:noobj+3) = 1;
% fprintf('[NoObj] Mean: %.4f (%.0f) STDF: %.4f STD%%: pix - %.4f (SNR %.4f), ffc only - %.4f, final - %.4f (real - %.4f %.4f %.4f)\n', mean(r(ind)), mean(means(ind)), mean(stds(ind)), mean(perc(ind)), 1/mean(perc(ind)), std(r(ind))/mean(r(ind)), sqrt(mean(perc(ind))^2+(std(r(ind))/mean(r(ind)))^2), std(d_raw1(ind) / mean(d_raw1(ind))), std(d_raw2(ind) / mean(d_raw2(ind))), std(d_raw3(ind) / mean(d_raw3(ind))));
% 
% 
% % ln
% ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
% ind(:, center:center+3) = 1;
% final = sqrt(mean(percln(ind))^2+(std(li(ind))/mean(li(ind)))^2);
% fprintf('Mean: %.4f STD: pix - %.4f, ffc only - %.4f, final - %.4f (%.4f)\n', mean(li(ind)), mean(percln(ind)), std(li(ind))/mean(li(ind)), final, final*mean(li(ind)) );
% 
% ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
% ind(:, between:between+3) = 1;
% final = sqrt(mean(percln(ind))^2+(std(li(ind))/mean(li(ind)))^2);
% fprintf('Mean: %.4f STD: pix - %.4f, ffc only - %.4f, final - %.4f (%.4f)\n', mean(li(ind)), mean(percln(ind)), std(li(ind))/mean(li(ind)), final, final*mean(li(ind)) );
% 
% ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
% ind(:, left:left+3) = 1;
% final = sqrt(mean(percln(ind))^2+(std(li(ind))/mean(li(ind)))^2);
% fprintf('Mean: %.4f STD: pix - %.4f, ffc only - %.4f, final - %.4f (%.4f)\n', mean(li(ind)), mean(percln(ind)), std(li(ind))/mean(li(ind)), final, final*mean(li(ind)) );
% 
% ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
% ind(:, noobj:noobj+3) = 1;
% final = sqrt(mean(percln(ind))^2+(std(li(ind))/mean(li(ind)))^2);
% fprintf('Mean: %.4f STD: pix - %.4f, ffc only - %.4f, final - %.4f (%.4f)\n', mean(li(ind)), mean(percln(ind)), std(li(ind))/mean(li(ind)), final, final*mean(li(ind)) );

% 
% %% slice std
% slice = loadMetaImage(slicepath);
% imagesc(slice)
% ind = zeros(size(slice, 1), size(slice, 2), 'logical');
% ind(sliceY1:sliceY2, sliceX1:sliceX2) = 1;
% fprintf('It leads to Mean: %.4f STD%%: %.4f on slice\n', mean(slice(ind)), std(slice(ind))/mean(slice(ind)));
% 
return;

%% crosstalk

pixsStd = zeros(crosstalkY2-crosstalkY1+1, crosstalkX2-crosstalkX1+1);

center = fix(crosstalkX2-crosstalkX1)/2;
for y=crosstalkY1:crosstalkY2
    for x=crosstalkX1:crosstalkX2

        v1 = d_raw(y, crosstalkX1+center, :);
        v2 = d_raw(y, x, :);
        v = v1 + v2;

        pixsStd(y, x-(crosstalkX1-1)) = (std(v)- std(v1)*sqrt(2)) / (2*std(v1) - std(v1)*sqrt(2));
    end
end
%plot(1:501, sum(pixsStd(:, :) / size(pixsStd, 1), 1), '.-g', 'DisplayName', '15mp'); hold on;
crosstalk = sum(pixsStd(:, center-8:center+8) ./ size(pixsStd, 1), 1);
fprintf('Crosstalk: ');
for c=1:numel(crosstalk)
    fprintf('%.4f ', crosstalk(c));
end
fprintf('\n');


%% binning efficiency

binningStat = zeros(6, 1);

for binning=1:6
    [d_raw g] = loadOnePosShots(onepospath, binning, shots, crosstalkX1, (crosstalkX1-1) + fix((crosstalkX2-crosstalkX1+1)/6)*6, crosstalkY1, (crosstalkY1-1) + fix((crosstalkY2-crosstalkY1+1)/6)*6);

    stds = zeros(size(d_raw, 1), size(d_raw, 2));

    n1 = (size(d_raw, 1));
    n2 = (size(d_raw, 2));

    parfor y=1:n1
        for x=1:n2
            m=permute(d_raw(y, x, :), [3 2 1]);
            stds(y, x) = std(m) / sqrt(mean(m));
        end
    end

    binningStat(binning) = mean(mean(stds), 2);
end
%plot(1:1:6, binningStat, '.-b'); hold on;
fprintf('... hence binning efficiency: ');
for b=1:numel(binningStat)
    fprintf('%.4f(%d) ', (binningStat(b) / binningStat(1)), b );
end
fprintf('\n');





