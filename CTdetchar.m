

path = 'd:/scans/CHAR/2430T-2inst/000-preCT';


raw = loadMetaImage(sprintf('%s/Finding-QuantumEfficiency/img-0.mhd', path));
g = sum(raw, 3) / size(raw, 3);


return;


import mlreportgen.dom.*
import mlreportgen.report.*
rpt = Report('dump/Report', 'pdf');

tp = TitlePage();
tp.Title = 'Teledyne Detector Characterization for estimation hw capabilies with the aspect of use in CT (hw binning1)';
tp.Image = which('sitelogo.png');
tp.PubDate = date();
rpt.add(tp);
br = PageBreak();
rpt.add(br);


%%%%%%%%%%%%%% ROI part

chapter = mlreportgen.report.Chapter();
chapter.Title = 'ROI stat';
add(rpt,chapter);

t = [{'SDD' '347 mm' ;
     'HV' '130 kV' ;
     'Current' '50 mkA' ;
     'Exposure' '200 ms';
     'ROI shots number' '1000';
     'FFC avg' '150';
     'ROI size' '100x100';
     }];
table = BaseTable(t);
table.Title = 'Configuration';
add(rpt,table);

br = PageBreak();
rpt.add(br);

%% SNRs
%filters = {'al-1mm', 'al-3mm', 'al-5mm', 'al-7mm', 'al-9mm'};
filters = {'al-1mm', 'al-30mm'};

SNRs = zeros(numel(filters), 1);
SNRDevs = zeros(numel(filters), 1);

SNROverPixels = zeros(numel(filters), 1);

for f = 1:numel(filters)
    [d_raw g] = loadOnePosShots2(sprintf('%s/fullroi/%s', path, char(filters(f))), X, Y);
    
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
            perc(y, x) = d / m * sqrt(norm(f));
            r(y, x) = (m/g(y,x));
        end
    end
    
%     if (f == 1)
%         imagesc(r);
%         colorbar;
%         title(sprintf('[%s] Flat-Field Corrected projection in att. ratio', char(filters(f))));
%         xlabel('Pixel');
%         ylabel('Pixel');
% 
%         fig = mlreportgen.report.Figure();
%         add(rpt, fig);
%         close all;  
% %          return;
%     end
    
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
set(gca, 'xtick', 1:numel(filters), 'xticklabel', filters);
xlabel('Al thickness, mm');
%set(gca,'XTick',[1:numel(filters)]);
ylabel('SNR');
fig = mlreportgen.report.Figure();
fig.Snapshot.Caption = 'SNR is calculated as division of the signal by its deviation. In the same conditions can be compared with other detectors.';
fig.Snapshot.Height = '10in';
add(rpt, fig);
close all;


plot(1:numel(filters), SNROverPixels, '.-r'); hold on;
title('SNR over pixels (matrix heterogeneity)');
set(gca,'xtick', 1:numel(filters), 'xticklabel', filters);
xlabel('Al thickness, mm');
%set(gca,'XTick',[1:numel(filters)]);
ylabel('SNR');
fig = mlreportgen.report.Figure();
fig.Snapshot.Caption = 'One of the most important characteristic for CT. It estimates fundamental detector heterogeneity over pixels. Its impossible to get CT image with noise less than this characteristic, because averaging doesnt effect on it. The calculation process involves gathering huge statistics such that poisson noise implied not affecting the result. Then STD over pixels is calculated using the same spectrum conditions for them.';
add(rpt, fig);
close all;

return;

%path = 'd:\Teledyne-CD42M2221\char\b1';
path = 'd:\Teledyne_\char';

% SNRs
% SNROverPixels
% mean(mean(means))
% mean(mean(stds))
% 
% return;

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



%return;

%imagesc(r(2000:4000, 1:1500))
%imagesc(r);
% 
% 
%%%%%%%%%%%%%% FULL part


%% dead&hot pixels

img = double(read(Tiff(sprintf('%s/full/ffc/gain.tif', path), 'r')));
ind1 = zeros(size(img, 1), size(img, 2), 'logical');

% ind1(2688:2913, 4095:4608) = 1; % rapper
% ind1(1:166, 1:167) = 1; % edge

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

gain = double(read(Tiff(sprintf('%s/full/ffc/gain.tif', path), 'r')));
dark = double(read(Tiff(sprintf('%s/full/ffc/offset.tif', path), 'r')));
img = double(read(Tiff(sprintf('%s/full/al-1mm/0000.tif', path), 'r')));

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
raw = zeros(size(gain, 1), size(gain, 2), 31);
j = 1;
list = dir(sprintf('%s/full/al-1mm', path));
for i=1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
    t = Tiff(sprintf('%s/full/al-1mm/%s', path, list(i).name), 'r');
    img1 = double(read(t));

    raw(:, :, j) = img1;% - dark;
    j = j + 1;
end

instabilityPixs = 0;
instability2CurrentPixs = 0;

for x = 1:size(raw, 2)
    for y = 1:size(raw, 1)
        if (workInd(y, x) == 0)
            continue;
        end
        
        sel = raw(y, x, 1:30);
        
        m = mean(sel);
        deviation = max(max(sel) - m, m - min(sel));
        if (deviation/m > 0.02)
            instabilityPixs = instabilityPixs + 1;
        end
        
        sel1 = raw(y, x, 30) - dark(y, x);
        sel2 = raw(y, x, 31) - dark(y, x);
        if ((abs(sel2 - sel1*2)/sel2) > 0.02)
            instability2CurrentPixs = instability2CurrentPixs + 1;
        end
    end
end

fprintf('instabilityPixs pixels (>0.02 dev/m) %d (%.4f %%) \n', instabilityPixs, instabilityPixs / alivePixelsNumber * 100 );
fprintf('instabilityPixs x2 current pixels (>0.02 change) %d (%.4f %%) \n', instability2CurrentPixs, instability2CurrentPixs / alivePixelsNumber * 100 );



chapter = mlreportgen.report.Chapter();
chapter.Title = 'Full frame stat';
add(rpt,chapter);

%t = [{'SDD' '548 mm' ;
t = [{'SDD' '347 mm' ;
     'HV' '130 kV' ;
     'Current' '50 mkA' ;
     'Exposure' '700 ms';
     'Avg' '30';
     'FFC avg' '150';
     }];
table = BaseTable(t);
table.Title = 'Configuration';
add(rpt,table);

t = [{'Dead pixels (<0.5mean)' sprintf('%d (%.4f %%)', deadPixelsNumber, deadPixelsNumber/totalPixelsNumber * 100);
    'Hot pixels (>1.5mean)' sprintf('%d (%.4f %%)', hotPixelsNumber, hotPixelsNumber/totalPixelsNumber * 100);
    'Heterogeneous pixels (>0.1meanR)' sprintf(' %d (%.4f %%) \n', hetersPixs, hetersPixs / alivePixelsNumber * 100 );
    'Instability pixels (>0.02 dev/mean)' sprintf('%d (%.4f %%) \n', instabilityPixs, instabilityPixs / alivePixelsNumber * 100 );
    'Instability pixels x2 current test (>0.02 change)' sprintf('%d (%.4f %%) \n', instability2CurrentPixs, instability2CurrentPixs / alivePixelsNumber * 100 );
     }];

table = BaseTable(t);
table.Title = 'Full frame stats';
add(rpt,table);



%plot(1:31, squeeze(raw(1000, 1000, 1:31)), 1:31)), '.-b');

%%
%%%%%%%%%%%%%% TOMO part
% 
% chapter = mlreportgen.report.Chapter();
% chapter.Title = 'Tomography';
% add(rpt,chapter);
% 
% textObj = Text(sprintf('Disc'));
% textObj.Style = {HAlign('left')};
% textObj.Bold = 1;
% add(rpt, textObj);
% 
% t = [{'SDD' '347 mm' ;
%      'SID' '40.5 mm';
%      'M' '8.56'
%      'Vox Size' '5.8 um'
%      'HV' '130 kV' ;
%      'Current' '50 mkA' ;
%      'Focus size' 'Small (8 um)' ;
%      'Exposure' '700 ms';
%      'Shots' '900';
%      'Rotation Step (deg)' '0.4';
%      'Avg' '10-20-30-40-50';
%      'FFC avg' '150';
%      'Preprocessing' 'ffc';
%      }];
% table = BaseTable(t);
% table.Title = 'Configuration';
% add(rpt,table);
% 
% br = PageBreak();
% rpt.add(br);
% snrCenter = zeros(5, 1);
% snrPeriphery = zeros(5, 1);
% 
% for i=1:5
%     slice = loadMetaImage(sprintf('%s/disc/1_%d/V/slice.mha', path, i));
% %     imagesc(slice);
% %     return;
%     % center
%     x = 2754; %1359; %
%     y = 2309; %1300;
%     roi = slice(y:y+100, x:x+100);
%     roi = reshape(roi, [numel(roi) 1])';
%     snrCenter(i) = mean(roi)/std(roi);
% 
%     %periphery
%     x = 708; %299; 
%     y = 2656; %1293; 
%     roi = slice(y:y+100, x:x+100);
%     roi = reshape(roi, [numel(roi) 1])';
%     snrPeriphery(i) = mean(roi)/std(roi);
% end
% 
% plot(10:10:50, snrCenter, '.-b', 'DisplayName', 'center'); hold on;
% plot(10:10:50, snrPeriphery, '.-g', 'DisplayName', 'periphery'); hold on;
% legend('show');
% title('Disc SNRs');
% xlabel('Avg');
% ylabel('SNR');
% fig = mlreportgen.report.Figure();
% fig.Snapshot.Caption = 'Disc SNR';
% add(rpt, fig);
% close all;
% 
% pic = Image(sprintf('%s/disc/screenshot.tif', path));
% pic.Width = "6in";
% pic.Height = "6in";
% add(rpt, pic);

%% Resolution
chapter = mlreportgen.report.Chapter();
chapter.Title = 'Resolution';
add(rpt,chapter);

t = [{'SDD' '347 mm' ;
     'HV' '130 kV' ;
     'Current' '50 mkA' ;
     'Focus' '8um'
     }];
table = BaseTable(t);
table.Title = 'Configuration';
add(rpt,table);

pic = Image(sprintf('%s/mtf/M1_.png', path));
pic.Style = {ScaleToFit};
add(rpt, pic);
textObj = Text('M1');
textObj.Style = {HAlign('center')};
rpt.add(textObj);
pic = Image(sprintf('%s/mtf/M23_.png', path));
pic.Style = {ScaleToFit};
add(rpt, pic);
textObj = Text('M23');
textObj.Style = {HAlign('center')};
rpt.add(textObj);

%Resolutions = [67.334 4.839];
Resolutions = [83.345 6.84];
t = [{'Magnification 1' sprintf('%.2f um', Resolutions(1));
    'Magnification 23' sprintf('%.2f um', Resolutions(2))  }];
table = BaseTable(t);
table.Title = 'Resolution';
add(rpt,table);

close(rpt);
save('dump/save.mat', 'SNRs', 'SNROverPixels', 'crosstalk', 'deadPixelsNumber', 'hotPixelsNumber', 'totalPixelsNumber', 'hetersPixs', 'alivePixelsNumber', 'instabilityPixs', 'instability2CurrentPixs', 'Resolutions');

