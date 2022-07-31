% import mlreportgen.dom.*
% import mlreportgen.report.*
% rpt = Report('dump/Report', 'pdf');
% 
% 
% chapter = mlreportgen.report.Chapter();
% chapter.Title = 'MTF';
% add(rpt,chapter);
% 
% pic = Image('d:\Teledyne-CD42M2221\char\b1\mtf\M1_.png');
% pic.Style = {ScaleToFit};
% add(rpt, pic);
% textObj = Text('M1');
% textObj.Style = {HAlign('center')};
% rpt.add(textObj);
% pic = Image('d:\Teledyne-CD42M2221\char\b1\mtf\M23_.png');
% pic.Style = {ScaleToFit};
% add(rpt, pic);
% textObj = Text('M23');
% textObj.Style = {HAlign('center')};
% rpt.add(textObj);
% 
% plot([1, 23], [67.334 4.839], '.-b');
% xlabel('Magnification');
% ylabel('Resolution');
% fig = mlreportgen.report.Figure();
% fig.Snapshot.Caption = 'Resolution is determined by finding MTF(I2-I1)/(I1+I2) level 10% ';
% fig.Snapshot.Height = '10in';
% add(rpt, fig);
% close all;
% 
% 
% close(rpt);
% return;

% 
gain = double(read(Tiff('c:\lol\b1\fullroi\al-30mm\0000.tif ')));
%bimg = binning2d(gain, 2);
imagesc(gain);
return;

snrCenter = zeros(5, 1);
snrPeriphery = zeros(5, 1);

for i=1:5
    slice = loadMetaImage(sprintf('d:/Teledyne-CD42M2221/char/b1/disc/1_%d/V/slice.mha', i));
    % imagesc(slice);
    % return;
    % center
    x = 2754;
    y = 2309;
    roi = slice(y:y+100, x:x+100);
    roi = reshape(roi, [numel(roi) 1])';
    snrCenter(i) = mean(roi)/std(roi);

    %periphery
    x = 708;
    y = 2656;
    roi = slice(y:y+100, x:x+100);
    roi = reshape(roi, [numel(roi) 1])';
    snrPeriphery(i) = mean(roi)/std(roi);
end

plot(10:10:50, snrCenter, '.-b', 'DisplayName', 'center'); hold on;
plot(10:10:50, snrPeriphery, '.-g', 'DisplayName', 'periphery'); hold on;
legend('show');
title('Disc SNRs');
xlabel('Avg');
ylabel('SNR');

