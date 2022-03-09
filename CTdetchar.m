

path = '/home/fna/scans/GOS/char';

import mlreportgen.dom.*
import mlreportgen.report.*
rpt = Report('dump/Report', 'pdf');

tp = TitlePage();
tp.Title = 'Prodis GOS X-Ray Detector Characterization for estimation hw capabilies with the aspect of use in CT';
tp.Image = which('LOGO_NDT_SITE.png');
tp.PubDate = date();
rpt.add(tp);
br = PageBreak();
rpt.add(br);

% textObj = Text('Radiography configuration');
% textObj.Style = {HAlign('center')};
% rpt.add(textObj);


%%%%%%%%%%%%%% ROI part

chapter = mlreportgen.report.Chapter();
chapter.Title = 'ROI stat';
add(rpt,chapter);

t = [{'SDD' '448.4 mm' ;
     'HV' '120 kV' ;
     'Current' '50 mkA' ;
     'Exposure' '450 ms';
     'ROI shots number' '1000';
     'FFC avg' '200';
     'ROI size' '100x100';
     }];
table = BaseTable(t);
table.Title = 'Configuration';
add(rpt,table);

br = PageBreak();
rpt.add(br);

%% SNRs
filters = {'al-1mm', 'al-2mm', 'al-3mm', 'al-4mm', 'al-5mm', 'al-6mm', 'al-7mm', 'al-8mm', 'al-9mm'};
%filters = {'al-1mm', 'al-2mm'};

SNRs = zeros(numel(filters), 1);
SNRDevs = zeros(numel(filters), 1);

SNROverPixels = zeros(numel(filters), 1);

for f = 1:numel(filters)
    [d_raw g] = loadOnePosShots2(sprintf('%s/roi/%s', path, char(filters(f))));

    means = zeros(size(d_raw, 1), size(d_raw, 2));
    stds = zeros(size(d_raw, 1), size(d_raw, 2));
    perc = zeros(size(d_raw, 1), size(d_raw, 2));
    r = zeros(size(d_raw, 1), size(d_raw, 2));
    rdev = zeros(size(d_raw, 1), size(d_raw, 2));
    
    n1 = (size(d_raw, 1));
    n2 = (size(d_raw, 2));
    for y=1:n1
        for x=1:n2
            s=permute(d_raw(y, x, :), [3 2 1]);
            d = std(s);
            m = median(s);
            means(y, x) = m;
            stds(y, x) = d / sqrt(m);
            perc(y, x) = d / m;
            r(y, x) = (m/g(y,x));
        end
    end
    
    if (f == 1)
        imagesc(r);
        colorbar;
        title(sprintf('[%s] Flat-Field Corrected projection in att. ratio', char(filters(f))));
        xlabel('Pixel');
        ylabel('Pixel');

        fig = mlreportgen.report.Figure();
        add(rpt, fig);
        close all;        
        
    end
    
    ind = zeros(size(d_raw, 1), size(d_raw, 2), 'logical');
    ind(:, :) = 1;
	SNRs(f) =  1/mean(perc(ind));
    SNR1 = 1/(mean(perc(ind))-std(perc(ind)));
    SNR2 = 1/(mean(perc(ind))+std(perc(ind)));
    SNRDevs(f) = SNR1 - SNR2;
    SNROverPixels(f) = mean(r(ind))/std(r(ind));
    f
end


errorbar(1:numel(filters), SNRs, SNRDevs, '.-b');
%plot(1:numel(filters), SNRs, '.-b');
title('SNR for pixel (DQE, Internal detector noise)');
%set(gca, 'xtick', 1:numel(filters), 'xticklabel', filters);
xlabel('Al thickness, mm');
set(gca,'XTick',[1:numel(filters)]);
ylabel('SNR');
fig = mlreportgen.report.Figure();
fig.Snapshot.Caption = 'SNR is calculated as division of the signal by its deviation. In the same conditions can be compared with other detectors.';
fig.Snapshot.Height = '10in';
add(rpt, fig);
close all;


plot(1:numel(filters), SNROverPixels, '.-r'); hold on;
title('SNR over pixels (matrix heterogeneity)');
%set(gca,'xtick', 1:numel(filters), 'xticklabel', filters);
xlabel('Al thickness, mm');
set(gca,'XTick',[1:numel(filters)]);
ylabel('SNR');
fig = mlreportgen.report.Figure();
fig.Snapshot.Caption = 'One of the most important characteristic for CT. It estimates fundamental detector heterogeneity over pixels. Its impossible to get CT image with noise less than this characteristic, because averaging doesnt effect on it. The calculation process involves gathering huge statistics such that poisson noise implied not affecting the result. Then STD over pixels is calculated using the same spectrum conditions for them.';
add(rpt, fig);
close all;

%% crosstalk

crosstalkX1=1;
crosstalkX2=size(d_raw, 2);
crosstalkY1=1;
crosstalkY2=size(d_raw, 1);

pixsStd = zeros(crosstalkY2-crosstalkY1+1, crosstalkX2-crosstalkX1+1);

center = fix((crosstalkX2-crosstalkX1)/2);
for y=crosstalkY1:crosstalkY2
    for x=crosstalkX1:crosstalkX2

        v1 = d_raw(y, crosstalkX1+center, :);
        v2 = d_raw(y, x, :);
        v = v1 + v2;

        pixsStd(y, x-(crosstalkX1-1)) = (std(v)- std(v1)*sqrt(2)) / (2*std(v1) - std(v1)*sqrt(2));
    end
end

crosstalk = sum(pixsStd(:, center-8:center+8) ./ size(pixsStd, 1), 1);

plot(center-8:center+8, crosstalk, '.-g'); hold on;
title('Crosstalk');
xlabel('Pixel');
ylabel('% of repeating');
fig = mlreportgen.report.Figure();
fig.Snapshot.Caption = 'Crosstalk is calculated by stat analyse. It effects on binning effeciency as well as on spatial resolution.';
add(rpt, fig);
close all;



%imagesc(r(2000:4000, 1:1500))
%imagesc(r);


%%%%%%%%%%%%%% FULL part

%% dead&hot pixels

img = double(read(Tiff(sprintf('%s/full/gain.tif', path), 'r')));
ind1 = zeros(size(img, 1), size(img, 2), 'logical');

ind1(2688:2913, 4095:4608) = 1; % rapper
ind1(1:166, 1:167) = 1; % edge

m = mean(img(~ind1));
img(ind1) = m;

totalPixelsNumber = numel(img);

indDead = img < (m * 0.5);
deadPixelsNumber = sum(sum(indDead));
fprintf('dead pixels (<0.5mean) %d (%.4f %%)\n', deadPixelsNumber, deadPixelsNumber/totalPixelsNumber);
indHot = (img > m * 1.5);
hotPixelsNumber = sum(sum(indHot));
fprintf('hot pixels (>1.5mean) %d (%.4f %%)\n', hotPixelsNumber, hotPixelsNumber/totalPixelsNumber);

workInd = ~(ind1 | indDead | indHot);
alivePixelsNumber = sum(sum(workInd));


%% heterogeneous pixels

gain = double(read(Tiff(sprintf('%s/full/gain.tif', path), 'r')));
dark = double(read(Tiff(sprintf('%s/full/offset.tif', path), 'r')));
img = double(read(Tiff(sprintf('%s/full/al-1mm/img_0001.tif', path), 'r')));

r = (img - dark) ./ (gain - dark);

r(~workInd) = mean(r(workInd));

hetersPixs = 0;

for x=1:300:size(r, 2)
    for y=1:300:size(r, 1)
        to_x = min(x + 299, size(r, 2));
        to_y = min(y + 299, size(r, 1));
        rA = r(y:to_y, x:to_x);
        workIndA = workInd(y:to_y, x:to_x);
        
        mA = mean(rA(workIndA));
        ind = abs(1 - (rA(workIndA)./mA)) > 0.1;
        
        hetersPixs = hetersPixs + sum(ind);
    end
end

fprintf('heterogeneous pixels (>0.1meanR) %d (%.4f %%) \n', hetersPixs, hetersPixs / alivePixelsNumber );

%% intensity stability, current x 2 test
raw = zeros(size(gain, 1), size(gain, 2), 36);
j = 1;
list = dir(sprintf('%s/full/al-1mm', path));
for i=1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
    t = Tiff(sprintf('%s/full/al-1mm/%s', path, list(i).name), 'r');
    img1 = double(read(t));

    raw(:, :, j) = img1;
    j = j + 1;
end

instabilityPixs = 0;
instability2CurrentPixs = 0;

for x = 1:size(raw, 2)
    for y = 1:size(raw, 1)
        if (workInd(y, x) == 0)
            continue;
        end
        
        sel = raw(y, x, 1:31);
        
        m = mean(sel);
        range = max(sel) - min(sel);
        if (range/m > 0.03)
            instabilityPixs = instabilityPixs + 1;
        end
        
        sel1 = raw(y, x, 31) - dark(y, x);
        sel2 = raw(y, x, 32) - dark(y, x);
        if ((abs(sel2 - sel1*2)/sel2) > 0.01)
            instability2CurrentPixs = instability2CurrentPixs + 1;
        end
    end
end

fprintf('instabilityPixs pixels (>0.03range/m) %d (%.4f %%) \n', instabilityPixs, instabilityPixs / alivePixelsNumber );
fprintf('instabilityPixs x2 current pixels (>0.01 change) %d (%.4f %%) \n', instability2CurrentPixs, instability2CurrentPixs / alivePixelsNumber );


chapter = mlreportgen.report.Chapter();
chapter.Title = 'Full frame stat';
add(rpt,chapter);

t = [{'SDD' '448.4 mm' ;
     'HV' '120 kV' ;
     'Current' '50 mkA' ;
     'Exposure' '450 ms';
     'Shots' '30 for stability, 5 for "x2 current test"';
     'Avg' '100';
     'FFC avg' '200';
     }];
table = BaseTable(t);
table.Title = 'Configuration';
add(rpt,table);

t = [{'Dead pixels (<0.5mean)' sprintf('%d (%.4f %%)', deadPixelsNumber, deadPixelsNumber/totalPixelsNumber * 100);
    'Hot pixels (>1.5mean)' sprintf('%d (%.4f %%)', hotPixelsNumber, hotPixelsNumber/totalPixelsNumber * 100);
    'Heterogeneous pixels (>0.1meanR)' sprintf(' %d (%.4f %%) \n', hetersPixs, hetersPixs / alivePixelsNumber * 100 );
    'Instability pixels (>0.03range/mean for 50 shots, 70s each)' sprintf('%d (%.4f %%) \n', instabilityPixs, instabilityPixs / alivePixelsNumber * 100 );
    'Instability pixels x2 current test (>0.01 change)' sprintf('%d (%.4f %%) \n', instability2CurrentPixs, instability2CurrentPixs / alivePixelsNumber * 100 );
     }];

table = BaseTable(t);
table.Title = 'Full frame stats';
add(rpt,table);
 

%plot(1:31, squeeze(raw(1000, 1000, 1:31)), 1:31)), '.-b');

%%%%%%%%%%%%%% TOMO part

chapter = mlreportgen.report.Chapter();
chapter.Title = 'Tomography';
add(rpt,chapter);


t = [{'SDD' '448.4 mm' ;
     'SID' '32.49 mm';
     'M' '13.8'
     'Vox Size' '3.57 um'
     'HV' '120 kV' ;
     'Current' '50 mkA' ;
     'Focus size' 'Small (8 um)' ;
     'Exposure' '450 ms';
     'Shots' '720';
     'Rotation Step (deg)' '0.5';
     'Avg' '10';
     'FFC avg' '200';
     'Preprocessing' 'ffc';
     }];
table = BaseTable(t);
table.Title = 'Medium quality configuration';
add(rpt,table);

br = PageBreak();
rpt.add(br);


%% beton
slice = loadMetaImage(sprintf('%s/tomo/beton/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(2155:2246, 942:1047);
roi = reshape(roi, [numel(roi) 1])';
betonMean = mean(roi);
betonStd = std(roi);

betonPic = Image(sprintf('%s/tomo/beton/V/slice.png', path));
betonPic.Width = "6in";
betonPic.Height = "6in";

textObj = Text(sprintf('Concrete. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;

add(rpt, textObj);
add(rpt, betonPic);

br = PageBreak();
rpt.add(br);


%% cyl
slice = loadMetaImage(sprintf('%s/tomo/cyl/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(1350:1600, 1350:1600);
roi = reshape(roi, [numel(roi) 1])';
cylMean = mean(roi);
cylStd = std(roi);

cylPic = Image(sprintf('%s/tomo/cyl/V/slice.png', path));
cylPic.Width = "6in";
cylPic.Height = "6in";

textObj = Text(sprintf('Cylinder. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;

add(rpt, textObj);
add(rpt, cylPic);

br = PageBreak();
rpt.add(br);


%% implants
slice = loadMetaImage(sprintf('%s/tomo/implants/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(1687:1787, 969:1069);
roi = reshape(roi, [numel(roi) 1])';
implantsMean = mean(roi);
implantsStd = std(roi);

implantsPic = Image(sprintf('%s/tomo/implants/V/slice.png', path));
implantsPic.Width = "6in";
implantsPic.Height = "6in";

textObj = Text(sprintf('Implants. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;

add(rpt, textObj);
add(rpt, implantsPic);

br = PageBreak();
rpt.add(br);

%% max-beton

t = [{'SDD' '448.4 mm' ;
     'SID' '20.13 mm';
     'M' '22.27'
     'Vox Size' '2.22 um'
     'HV' '70 kV' ;
     'Current' '50 mkA' ;
     'Focus size' 'Small (5 um)' ;
     'Exposure' '3000 ms';
     'Shots' '1200';
     'Rotation Step (deg)' '0.3';
     'Avg' '5';
     'FFC avg' '200';
     'Preprocessing' 'ffc';
     }];
table = BaseTable(t);
table.Title = 'High quality configuration';
add(rpt,table);

br = PageBreak();
rpt.add(br);

slice = loadMetaImage(sprintf('%s/tomo/max-beton/V/slice.mha', path));
roi = slice(1459:1525, 1030:1080);
roi = reshape(roi, [numel(roi) 1])';
maxBetonMean = mean(roi);
maxBetonStd = std(roi);

maxBetonPic = Image(sprintf('%s/tomo/max-beton/V/slice.png', path));
maxBetonPic.Width = "6in";
maxBetonPic.Height = "6in";

textObj = Text(sprintf('Concrete. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;

add(rpt, textObj);
add(rpt, maxBetonPic);


save('dump/save.mat', 'SNRs', 'SNROverPixels', 'crosstalk', 'deadPixelsNumber', 'hotPixelsNumber', 'totalPixelsNumber', 'hetersPixs', 'alivePixelsNumber', 'instabilityPixs', 'instability2CurrentPixs', 'betonStd', 'betonMean', 'cylStd', 'cylMean', 'implantsStd', 'implantsMean', 'maxBetonStd', 'maxBetonMean', 'betonPic', 'cylPic', 'implantsPic', 'maxBetonPic');
close(rpt);

