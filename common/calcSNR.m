function [snr] = calcSNR(img, x, y, side)

roi = img(y:y+side, x:x+side);
roi = reshape(roi, [numel(roi), 1]);
snr = mean(roi) / std(roi);
