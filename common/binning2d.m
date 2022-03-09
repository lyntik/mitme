function [binimg] = binning2d(img, value)

if (ndims(img) ~= 2)
    errID = 'binning2d:BadDimsNumber';
    msg = 'Function supports only 2-dimentional images';
    baseException = MException(errID, msg);
    throw(baseException)    
end    

if (value < 2) % no no, func works fine or at least MUST work fine. this check is to avoid extra calculations =)
    binimg = img;
    return;
end

if (size(img, 1) < value || size(img, 2) < value)
    errID = 'binning2d:BadImageSize';
    msg = 'Image size is too small to perform the binning.';
    baseException = MException(errID, msg);
    throw(baseException)
end
% 
if (mod(size(img, 1), value) ~= 0) 
    img = img(1:size(img, 1) - mod(size(img, 1), value), :);
end
if (mod(size(img, 2), value) ~= 0) 
    img = img(:, 1:size(img, 2) - mod(size(img, 2), value));
end

binimg = zeros(size(img, 1)/value, size(img, 2) / value);
for x=1:value:size(img,2)
    for y=1:value:size(img,1)
        binimg((y-1)/value+1, (x-1)/value+1) = sum(sum(img(y:y+(value-1), x:x+(value-1))), 2);
    end
end    

