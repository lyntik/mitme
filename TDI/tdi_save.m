
imgInd = 5;

hImg = imshow(mat2gray(imgs(:, :, imgInd)));
mm_per_pixel = 0.05;
XDataInMeters = get(hImg,'XData')*mm_per_pixel; 
YDataInMeters = get(hImg,'YData')*mm_per_pixel;
set(hImg,'XData',XDataInMeters,'YData',YDataInMeters);    
set(gca,'XLim',XDataInMeters,'YLim',YDataInMeters);
hline = imdistline(gca,[0.3 5.3], [1.3 1.3]);
setLabelTextFormatter(hline, '%.0f mm');
