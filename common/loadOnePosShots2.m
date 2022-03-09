function [raw g] = loadOnePosShots2(path)

% 
gain = double(read(Tiff(sprintf('%s/ffc/gain.tif', path), 'r')));
dark = double(read(Tiff(sprintf('%s/ffc/offset.tif', path), 'r')));

division = 1;
division = 4;

g = gain-dark;
g = g(4:129, 4:129);
%g = g(1:size(g, 1) / division, 1:size(g, 2) / division); 

list = dir(path);
shots = 0;
for i=1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
    if (shots == 0)
        img = read(Tiff(sprintf('%s/%s', path, list(i).name), 'r'));
    end
    shots = shots + 1;
end


%raw = zeros(size(img, 1)/division, size(img, 2)/division, shots);
raw = zeros(126, 126, shots);

j = 1;
for i=1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
    t = Tiff(sprintf('%s/%s', path, list(i).name), 'r');
    img1 = double(read(t)) - dark;
    
    %raw(:, :, j) = img1;
    %raw(:, :, j) = img1(1:size(img1,1) / division, 1:size(img1, 2) / division);
    img1 = img1(4:129, 4:129);
    raw(:, :, j) = img1;
    
    j = j + 1;
end

