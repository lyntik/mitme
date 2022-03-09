
%% static

t = Tiff('c:/scans/magicSNR/al/5000ms.tif', 'r');
img = double(read(t));
imagesc(img);

t = Tiff('c:/scans/magicSNR/5000ms.tif', 'r');
gain = double(read(t));
t = Tiff('c:/scans/magicSNR/5000ms-dark.tif', 'r');
dark = double(read(t));

r = (img - dark) ./ (gain - dark);

sel = r(421:430, 801:810);
sel = double(reshape(sel, [numel(sel) 1]));
mean(sel)/std(sel)

histogram(sel)

%% ~tdi

t = Tiff('c:/scans/magicSNR/50ms.tif', 'r');
gain = double(read(t));
t = Tiff('c:/scans/magicSNR/50ms-dark.tif', 'r');
dark = double(read(t));

i = 0;
sel = zeros(10, 10);
for x=1:10
    for y=1:10
        t = Tiff(sprintf('c:/scans/magicSNR/al/50ms/%04d.tif', i), 'r');
        i = i + 1;
        img = double(read(t));
        r = (img - dark) ./ (gain - dark);
        %sel(y, x) = sum(img(420+y, 800+x:899+x), 2);
        sel(y, x) = sum(sum(r(421:430, 801:810), 2), 1) / 100.;
    end
end
sel = double(reshape(sel, [numel(sel) 1]));
mean(sel)/std(sel)

histogram(sel)


return;

%% static
t = Tiff('c:/scans/magicSNR/5000ms.tif', 'r');
img = read(t);
t = Tiff('c:/scans/magicSNR/5000ms-dark.tif', 'r');
dark = read(t);

img = img - dark;

%imagesc(img);
sel = img(421:430, 801:810);
sel = double(reshape(sel, [numel(sel) 1]));
mean(sel)/std(sel)

%histogram(sel)

%% ~tdi
t = Tiff('c:/scans/magicSNR/50ms.tif', 'r');
img = read(t);
t = Tiff('c:/scans/magicSNR/50ms-dark.tif', 'r');
dark = read(t);

img = img - dark;

%imagesc(img);
%t = Tiff('c:/scans/50ms.tif', 'r');

i = 0;
sel = zeros(10, 10);
for x=1:10
    for y=1:10
        t = Tiff(sprintf('c:/scans/magicSNR/50ms/%04d.tif', i), 'r');
        i = i + 1;
        img = read(t);
        img = img - dark;
        %sel(y, x) = sum(img(420+y, 800+x:899+x), 2);
        sel(y, x) = sum(sum(img(421:430, 801:810), 2), 1);
    end
end
sel = double(reshape(sel, [numel(sel) 1]));
mean(sel)/std(sel)

%histogram(sel)

%imagesc(roiStatic);

return;

