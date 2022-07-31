function [raw g] = loadOnePosShots2(path, x, y)

path

% 
gain = double(read(Tiff(sprintf('%s/ffc/gain.tif', path), 'r')));
dark = double(read(Tiff(sprintf('%s/ffc/offset.tif', path), 'r')));

% roi
% if (CT_config.Binning == 1):
% 	f.setParam('ROIX', 2000)
% 	f.setParam('ROIY', 3100)
% else:
% 	f.setParam('ROIX', 1061)
% 	f.setParam('ROIY', 1666)

% x = 1257;
% y = 1372;
% x = 1615;
% y = 1981;


g = gain-dark;
g = g(y:y+99, x:x+99);
dark = dark(y:y+99, x:x+99);

%g = binning2d(dark, 2);
%dark = binning2d(dark, 2);

%g = g(1:size(g, 1) / division, 1:size(g, 2) / division); 

list = dir(path);
shots = 0;
for i=1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
%     if (shots == 0)
%         img = read(Tiff(sprintf('%s/%s', path, list(i).name), 'r'));
%     end
    shots = shots + 1;
end


raw = zeros(100, 100, shots);

j = 1;
for i=1:1:size(list, 1)
    if (list(i).isdir() == true) 
        continue
    end
    t = Tiff(sprintf('%s/%s', path, list(i).name), 'r');
    img1 = double(read(t));
    
    img1 = img1(y:y+99, x:x+99);
    %img1 = binning2d(img1, 2);
    img1 = img1 - dark;
    
%     t = Tiff(sprintf('%s/%s', path, list(i+1).name), 'r');
%     img = double(read(t));
%     img = img(y:y+99, x:x+99);
%     img = img - dark;
        
    raw(:, :, j) = img1;
    
    j = j + 1;
end

