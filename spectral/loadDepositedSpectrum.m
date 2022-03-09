function [D] = loadDepositedSpectrum(path, experimentNumber, deposOffset, region, iterations)


files = dir(sprintf('%s/%d/%d/*.txt', path, experimentNumber, 0));
y = zeros(size(files, 1) - 1, 1);
    
filedata = fileread(sprintf('%s/%d/itr.txt', path, experimentNumber));
if (~exist('iterations', 'var')) || (iterations == -1)
    iterations = sscanf(filedata, '%d');
end

cachefile = sprintf('cache/d_%d_%d_%d_%d_%d.mat', experimentNumber, region.left, region.right, region.top, region.bottom);
usecache = false;
% if (exist(cachefile, 'file') == 2)
%     load(cachefile, 'y_save', 'iterations_save');
%     
%     if ((size(y_save, 1) == size(y, 1)) && ...
%         (iterations_save == iterations))
%         usecache = true;
%         y = y_save;
%     end
% end

global colors;
colorIndex = 1;


if (~usecache)
    for itr = 0:iterations

        files = dir(sprintf('%s/%d/%d/*.txt', path, experimentNumber, itr));

        summprev = -1;
        i = 0;

        z = zeros(size(files, 1) - 1, 1);

        for file = files'

            ds = set(dataset('File', sprintf('%s/%d/%d/%s', path, experimentNumber, itr, file.name)), 'VarNames', {'11'});
            dd = str2num(char(ds.x11));

            if ~exist('region', 'var') 
                summ = sum(sum(dd, 1), 2);
            else
                summ = sum(sum(dd(region.top:region.bottom, region.left:region.right), 1), 2);
            end

            if (i ~= 0)
                y(i) = y(i) + (summprev - summ);
                z(i) = (summprev - summ);
            end

            i = i + 1;
            summprev = summ;
        end
        
        

        %plot(1:size(files, 1) - 1, z, char(colors(colorIndex))); hold on;
        colorIndex = colorIndex + 1;
        if (colorIndex == 8)
            colorIndex = 1;
        end

    end
    
   
    y = y ./ (iterations + 1);
    
    y_save = y; iterations_save = iterations;
    save(cachefile, 'y_save', 'iterations_save');    
    
end



if exist('deposOffset', 'var') 
    y = [y(1+deposOffset:size(y, 1)); zeros(deposOffset, 1) ];
end

D = y';

