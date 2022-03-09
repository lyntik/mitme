function [r] = dose(inDir, conf, matrixNumber, x, y)

s = sprintf('%s/%d/dumpDeposit/%d/%02d_%02d.txt', inDir, conf, matrixNumber, x, y);

ds = dataset('File', s);
dd = double(ds);
            
r = sum(dd(:,1) .* dd(:,2));
