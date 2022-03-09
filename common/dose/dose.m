function [r] = dose(inDir, x, y)

s = sprintf('%s/%02d_%02d.txt', inDir, x, y);

ds = dataset('File', s);
dd = double(ds);
            
r = sum(dd(:,1) .* dd(:,2));
