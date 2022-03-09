function f = costMD(X)

n = 45;

X
% 
% pause(3)
% 
% f = sum(X)
% return;

X = [X 160];
X = round(X);

thr = '';
for x=X
    thr = strcat(thr, sprintf('%d,', x));
end


system(sprintf('cd /mnt/ramdisk && ./createtiff --threshold=%s', thr));
system('cd //mnt/ramdisk && ./recon.sh');


mu = zeros(4, 5);

for bin=1:4
    img = loadMetaImage(sprintf('/mnt/ramdisk/fdk%d.mha', bin-1));
    
    mu(bin, 1) = sum(sum(sum(img(55:57, 75:77, 9:13), 1), 2), 3)/n;
    mu(bin, 2) = sum(sum(sum(img(72:74, 65:67, 9:13), 1), 2), 3)/n;
    mu(bin, 3) = sum(sum(sum(img(72:74, 45:47, 9:13), 1), 2), 3)/n;
    mu(bin, 4) = sum(sum(sum(img(55:57, 35:37, 9:13), 1), 2), 3)/n;
    mu(bin, 5) = sum(sum(sum(img(55:57, 53:55, 9:13), 1), 2), 3)/n;
end


% Slope
x1 = 1;
x2 = 2;

diff = 0;
for b=2:4
    y1 = mu(b-1, 1);
    y2 = mu(b, 1);
    slope1 = -(y1-y2)/(x2-x1);

    y1 = mu(b-1, 4);
    y2 = mu(b, 4);
    slope2 = -(y1-y2)/(x2-x1);

    diff = diff + abs(slope1-slope2);
end


f = -diff



