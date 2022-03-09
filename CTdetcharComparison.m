global colors;

detectors = {'CsI', 'GOS' };
filters = {'al-1mm', 'al-2mm', 'al-3mm', 'al-4mm', 'al-5mm', 'al-6mm', 'al-7mm', 'al-8mm', 'al-9mm' };
%DQENorm = [ 1 (8.5^2/49.5^2)* 5 ];
DQENorm = [ 1 1 ];


import mlreportgen.dom.*
import mlreportgen.report.*
rpt = Report('dump/Comparison', 'pdf');

tp = TitlePage();
s = detectors(1);
for d=2:numel(detectors)
    s = strcat(s, ', ', char(detectors(d)));
end    
tp.Title = ['X-Ray Detectors Comparison (' s ')'];
tp.PubDate = date();
rpt.add(tp);
br = PageBreak();
rpt.add(br);


% SNR Pixel
DetectorsSNRs = zeros(numel(detectors), numel(filters));

colorIndex = 1;
for d=1:numel(detectors)
    load(sprintf('dump/%s/save.mat', char(detectors(d))));
    
    DetectorsSNRs(d, :) = SNRs;
    
    plot(1:numel(filters), SNRs, char(colors(colorIndex)), 'DisplayName', char(detectors(d))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end
legend('show');
title('SNR');
xlabel('Al thickness, mm');
%set(gca,'XTick',[1:numel(filters)]);
ylabel('SNR');
fig = Figure();
fig.Snapshot.Caption = 'SNR is calculated as division of the signal by its deviation. Can be compared with other detectors to estimate relative DQE.';
fig.Snapshot.Height = '10in';
add(rpt, fig);
print('dump/SNR.png','-dpng');
close all;    

% DQE Comparison
colorIndex = 1;
for d=2:numel(detectors)
    plot(1:numel(filters), (DetectorsSNRs(1, :)./DetectorsSNRs(d, :)).^2 .* DQENorm(d), char(colors(colorIndex)), 'DisplayName', sprintf('relative dqe %s/%s', char(detectors(1)), char(detectors(d)))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end
legend('show');
title('Relative DQE');
%set(gca, 'xtick', 1:numel(filters), 'xticklabel', filters);
xlabel('Al thickness, mm');
ylabel('Relative DQE');
fig = Figure();
add(rpt, fig);
print('dump/RDQE.png','-dpng');
close all;    

% SNR Over Pixels
colorIndex = 1;
for d=1:numel(detectors)
    load(sprintf('dump/%s/save.mat', char(detectors(d))));
    
    plot(1:numel(filters), SNROverPixels, char(colors(colorIndex)), 'DisplayName', char(detectors(d))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end
legend('show');
title('SNR (FFC)');
%set(gca, 'xtick', 1:numel(filters), 'xticklabel', filters(1:end));
xlabel('Al thickness, mm');
ylabel('SNR');
fig = Figure();
fig.Snapshot.Caption = 'One of the most important characteristic for CT. It estimates fundamental detector heterogeneity over pixels. Its impossible to get image with noise less than this characteristic, because averaging has no effect on it.'
    'The calculation process involves gathering huge statistics such that poisson noise implied not affecting the result. Then STD over pixels is calculated using the same spectrum conditions for them.';
fig.Snapshot.Height = '10in';
add(rpt, fig);
print('dump/SNR-FFC.png','-dpng');
close all;    

% Crosstalk
colorIndex = 1;
for d=1:numel(detectors)
    load(sprintf('dump/%s/save.mat', char(detectors(d))));
    
    plot(1:numel(crosstalk), crosstalk, char(colors(colorIndex)), 'DisplayName', char(detectors(d))); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
end
legend('show');
title('Crosstalk');
xlabel('Pixel');
ylabel('% of repeating');
fig = Figure();
fig.Snapshot.Caption = 'Crosstalk is calculated by stat analyse. It effects on binning effeciency as well as on spatial resolution.';
add(rpt, fig);
print('dump/crosstalk','-dpng');
close all;

% close(rpt);
% return;

br = PageBreak();
rpt.add(br);


% Rest
% rmse = zeros(numel(detectors), 1);
% for d=1:numel(detectors)
%     load(sprintf('dump/%s/save.mat', char(detectors(d))));
%     [xData, yData] = prepareCurveData( xCountCharCurrents, intensitymCurrWithDark );
%     ft = fittype( 'poly1' );
%     [fitresult, gof] = fit( xData, yData, ft );
%     rmse(d) = gof.rmse;
% end    
% 
% br = PageBreak();
% rpt.add(br);
% t = [{'Parameter name' 'prodis' 'teledyne';
%      'Dark current'  sprintf('%.4f%% (%d)', 671/65535*100, 671) sprintf('%.4f%% (%d)', 173/16384*100, 173);
%      'RMSE for fit of linear function to IntensityVSCurrent' sprintf('%.2f', rmse(1)) sprintf('%.2f', rmse(2));}];
% 
% table = BaseTable(t);
% table.Title = 'Params';
% add(rpt,table);

DetectorsDeadPixelsNumber = zeros(1, numel(detectors));
DetectorsHotPixelsNumber = zeros(1, numel(detectors));
DetectorsTotalPixelsNumber = zeros(1, numel(detectors));
DetectosHetersPixs = zeros(1, numel(detectors));
DetectorsAlivePixelsNumber = zeros(1, numel(detectors));
DetectorsInstabilityPixs = zeros(1, numel(detectors));
Detectorsinstability2CurrentPixs = zeros(1, numel(detectors));

for d=1:numel(detectors)
    load(sprintf('dump/%s/save.mat', char(detectors(d))));
    DetectorsDeadPixelsNumber(d) = deadPixelsNumber;
    DetectorsHotPixelsNumber(d) = hotPixelsNumber;
    DetectorsTotalPixelsNumber(d) = totalPixelsNumber;
    DetectosHetersPixs(d) = hetersPixs;
    DetectorsAlivePixelsNumber(d) = alivePixelsNumber;
    DetectorsInstabilityPixs(d) = instabilityPixs;
    Detectorsinstability2CurrentPixs(d) = instability2CurrentPixs;
end

t = [{'Parameter name' 'CsI' 'GOS';
    'Dead pixels (<0.5mean)' sprintf('%d (%.4f %%)', DetectorsDeadPixelsNumber(1), DetectorsDeadPixelsNumber(1)/DetectorsTotalPixelsNumber(1) * 100)  sprintf('%d (%.4f %%)', DetectorsDeadPixelsNumber(2), DetectorsDeadPixelsNumber(2)/DetectorsTotalPixelsNumber(2) * 100);
    'Hot pixels (<0.5mean)' sprintf('%d (%.4f %%)', DetectorsHotPixelsNumber(1), DetectorsHotPixelsNumber(1)/DetectorsTotalPixelsNumber(1) * 100)  sprintf('%d (%.4f %%)', DetectorsHotPixelsNumber(2), DetectorsHotPixelsNumber(2)/DetectorsTotalPixelsNumber(2) * 100);
    'Heterogeneous pixels (<0.5mean)' sprintf('%d (%.4f %%)', DetectosHetersPixs(1), DetectosHetersPixs(1)/DetectorsAlivePixelsNumber(1) * 100)  sprintf('%d (%.4f %%)', DetectosHetersPixs(2), DetectosHetersPixs(2)/DetectorsAlivePixelsNumber(2) * 100);
    'Instability pixels (>0.03range/mean for 50 shots, 70s each)' sprintf('%d (%.4f %%)', DetectorsInstabilityPixs(1), DetectorsInstabilityPixs(1)/DetectorsAlivePixelsNumber(1) * 100)  sprintf('%d (%.4f %%)', DetectorsInstabilityPixs(2), DetectorsInstabilityPixs(2)/DetectorsAlivePixelsNumber(2) * 100);
    'Instability pixels x2 current test (>0.01 change)' sprintf('%d (%.4f %%)', Detectorsinstability2CurrentPixs(1), Detectorsinstability2CurrentPixs(1)/DetectorsAlivePixelsNumber(1) * 100)  sprintf('%d (%.4f %%)', Detectorsinstability2CurrentPixs(2), Detectorsinstability2CurrentPixs(2)/DetectorsAlivePixelsNumber(2) * 100);
     }];

table = BaseTable(t);
table.Title = 'Full frame params';
add(rpt,table);
br = PageBreak();
rpt.add(br);

% tomo part. hardcode 
% beton
textObj = Text(sprintf('Medium quality. Concrete. (same coniditions)'));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
path = '/home/fna/scans/CsI/char';
slice = loadMetaImage(sprintf('%s/tomo/beton/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(868:950, 1770:1870);
roi = reshape(roi, [numel(roi) 1])';
betonPic = Image(sprintf('%s/tomo/beton/V/slice.png', path));
betonPic.Width = "4in";
betonPic.Height = "4in";
textObj = Text(sprintf('CsI. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, betonPic);

path = '/home/fna/scans/GOS/char';
slice = loadMetaImage(sprintf('%s/tomo/beton/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(2155:2246, 942:1047);
roi = reshape(roi, [numel(roi) 1])';
betonMean = mean(roi);
betonStd = std(roi);
betonPic = Image(sprintf('%s/tomo/beton/V/slice.png', path));
betonPic.Width = "4in";
betonPic.Height = "4in";
textObj = Text(sprintf('GOS. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, betonPic);

br = PageBreak();
rpt.add(br);

% cyl
textObj = Text(sprintf('Medium quality. Cylinder. (same coniditions)'));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
path = '/home/fna/scans/CsI/char';
slice = loadMetaImage(sprintf('%s/tomo/cyl/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(1350:1600, 1350:1600);
roi = reshape(roi, [numel(roi) 1])';
cylPic = Image(sprintf('%s/tomo/cyl/V/slice.png', path));
cylPic.Width = "4in";
cylPic.Height = "4in";
textObj = Text(sprintf('CsI. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, cylPic);

path = '/home/fna/scans/GOS/char';
slice = loadMetaImage(sprintf('%s/tomo/cyl/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(1350:1600, 1350:1600);
roi = reshape(roi, [numel(roi) 1])';
cylMean = mean(roi);
cylStd = std(roi);
cylPic = Image(sprintf('%s/tomo/cyl/V/slice.png', path));
cylPic.Width = "4in";
cylPic.Height = "4in";
textObj = Text(sprintf('GOS. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, cylPic);

br = PageBreak();
rpt.add(br);

% implants
textObj = Text(sprintf('Medium quality. Implants. (same coniditions)'));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
path = '/home/fna/scans/CsI/char';
slice = loadMetaImage(sprintf('%s/tomo/implants/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(1442:1562, 880:980);
roi = reshape(roi, [numel(roi) 1])';
implantsMean = mean(roi);
implantsStd = std(roi);
implantsPic = Image(sprintf('%s/tomo/implants/V/slice.png', path));
implantsPic.Width = "4in";
implantsPic.Height = "4in";
textObj = Text(sprintf('CsI. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, implantsPic);

path = '/home/fna/scans/GOS/char';
slice = loadMetaImage(sprintf('%s/tomo/implants/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(1687:1787, 969:1069);
roi = reshape(roi, [numel(roi) 1])';
implantsPic = Image(sprintf('%s/tomo/implants/V/slice.png', path));
implantsPic.Width = "4in";
implantsPic.Height = "4in";
textObj = Text(sprintf('GOS. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, implantsPic);

br = PageBreak();
rpt.add(br);


% max beton
textObj = Text(sprintf('High quality. Concrete. (conditions are a bit different)'));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);

path = '/home/fna/scans/CsI/char';
slice = loadMetaImage(sprintf('%s/tomo/max-beton/V/slice.mha', path));
imagesc(slice); colormap('gray');
roi = slice(1052:1104, 1542:1600);
roi = reshape(roi, [numel(roi) 1])';
maxBetonPic = Image(sprintf('%s/tomo/max-beton/V/slice.png', path));
maxBetonPic.Width = "4in";
maxBetonPic.Height = "4in";
textObj = Text(sprintf('CsI. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, maxBetonPic);

path = '/home/fna/scans/GOS/char';
slice = loadMetaImage(sprintf('%s/tomo/max-beton/V/slice.mha', path));
roi = slice(1459:1525, 1030:1080);
roi = reshape(roi, [numel(roi) 1])';
maxBetonPic = Image(sprintf('%s/tomo/max-beton/V/slice.png', path));
maxBetonPic.Width = "4in";
maxBetonPic.Height = "4in";
textObj = Text(sprintf('GOS. mean %.4f STD %.4f (%.2f %%)', mean(roi), std(roi), std(roi)/mean(roi) * 100));
textObj.Style = {HAlign('left')};
textObj.Bold = 1;
add(rpt, textObj);
add(rpt, maxBetonPic);



close(rpt);

