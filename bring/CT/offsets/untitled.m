

t = Tiff('/media/fna/storage 2T/scans/poli2/axe-src-stability/1/shot_0001.tif', 'r');
img = read(t);
prof = sum(img(:, 1300:1400), 2);
imwrite(mat2gray(prof), '1.tif');
return;

%% 
M = 492/50;
% X
[offsetsAxe] = subPixelOffsets('/media/fna/storage 2T/scans/poli2/axe-src-stability/3/shot_%04d.tif', 10, -1, 364, 1, 442, 500, 550, 1);
[offsetsSrc] = subPixelOffsets('/media/fna/storage 2T/scans/poli2/axe-src-stability/3/shot_%04d.tif', 10, 1, 529, 500, 600, 500, 550, 1);

%M./(M-1)
plot(1:numel(offsetsAxe), offsetsAxe, '.-b', 'DisplayName', 'axe+src'); hold on;
plot(1:numel(offsetsSrc), offsetsSrc.*(M/(M-1)), '-.r*', 'DisplayName', 'src real movement'); hold on;
plot(1:numel(offsetsSrc), offsetsSrc, '.-r', 'DisplayName', 'src'); hold on;

plot(1:numel(offsetsSrc), offsetsAxe-offsetsSrc, '.-k', 'DisplayName', 'axe' ); hold on;

title('X offsets (3 exp)');
legend('show');

%% Y
[offsetsAxe] = subPixelOffsets('/media/fna/storage 2T/scans/poli2/axe-src-stability/3/shot_%04d.tif', 10, 1, 376, 1300, 1400, 250, 450, 2);
[offsetsSrc] = subPixelOffsets('/media/fna/storage 2T/scans/poli2/axe-src-stability/3/shot_%04d.tif', 10, -1, 943, 100, 200, 850, 1000, 2);

plot(1:numel(offsetsAxe), offsetsAxe, '.-b', 'DisplayName', 'axe+src'); hold on;
plot(1:numel(offsetsSrc), offsetsSrc.*(M/(M-1)), '-.r*', 'DisplayName', 'src real movement'); hold on;
plot(1:numel(offsetsSrc), offsetsSrc, '.-r', 'DisplayName', 'src'); hold on;

plot(1:numel(offsetsSrc), offsetsAxe-offsetsSrc, '.-k', 'DisplayName', 'axe' ); hold on;

title('Y offsets');
legend('show');

