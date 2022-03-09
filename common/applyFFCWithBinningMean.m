function [rimg] = applyFFCWithBinningMean(img, gain, dark, binning)

if (ndims(img) ~= 2)
    errID = 'binning2d:BadDimsNumber';
    msg = 'Function supports only 2-dimentional images';
    baseException = MException(errID, msg);
    throw(baseException)    
end    

if (binning < 2) 
    rimg = img;
    return;
end

if (size(img, 1) < binning || size(img, 2) < binning)
    errID = 'binning2d:BadImageSize';
    msg = 'Image size is too small to perform the binning.';
    baseException = MException(errID, msg);
    throw(baseException)
end
% 
if (mod(size(img, 1), binning) ~= 0) 
    img = img(1:size(img, 1) - mod(size(img, 1), binning), :);
end
if (mod(size(img, 2), binning) ~= 0) 
    img = img(:, 1:size(img, 2) - mod(size(img, 2), binning));
end

rimg = zeros(size(img, 1) / binning, size(img, 2) / binning);
att = (double(img) - dark) ./ (double(gain) - dark);
ind = zeros(size(img, 1), size(img, 2), 'logical');
for x=1:binning:size(img,2)
    for y=1:binning:size(img,1)
        ind(:, :) = 0;
        ind(y:y+(binning-1), x:x+(binning-1)) = 1;
        rimg((y-1)/binning+1, (x-1)/binning+1) = sum(1/mean(att(ind)) .* att(ind) .* mean(img(ind)));
    end
end    

