function [raw g] = loadOnePosShots(path, binning, shots, x1, x2, y1, y2)

% 
t = Tiff(sprintf('%s/ffc/gain.tif', path), 'r');
gain = double(read(t));
gain = binning2d(gain(y1:y2, x1:x2), binning);

t = Tiff(sprintf('%s/ffc/offset.tif', path), 'r');
dark = double(read(t));
dark = binning2d(dark(y1:y2, x1:x2), binning);

g = gain-dark;

list = dir(path);
shots = 0;
for i=1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
    shots = shots + 1;
end    


raw = zeros(fix((y2-y1+1)/binning), fix((x2-x1+1)/binning), shots);

j = 1;
%for i=1:1:shots
for i=1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
    %t = Tiff(sprintf('%s/img_%04d.tif', path, i-1), 'r');
    t = Tiff(sprintf('%s/%s', path, list(i).name), 'r');
    img1 = double(read(t));
    img1 = binning2d(img1(y1:y2, x1:x2), binning) - dark;

    raw(:, :, j) = img1;
    j = j + 1;
end

