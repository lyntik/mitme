

%%% optim for detected. whole region, norm by iterations

path = '//192.168.0.105/work/politeh/pixet_spectral';
%path = '//192.168.0.105/work/politeh/thrscan/bias200clock16';

for i = 0:98
    i
    filedata = fileread(sprintf('%s/%d/itr.txt', path, i));
    iterations = sscanf(filedata, '%d');
    
    files = dir(sprintf('%s/%d/%d/*.txt', path, i, 0));
    integral = zeros(255, 256, size(files, 1));
    
    z = 1;
    for file = files'
        for itr = 0:iterations
            ds = set(dataset('File', sprintf('%s/%d/%d/%s', path, i, itr, file.name)), 'VarNames', {'11'});
            dd = str2num(char(ds.x11));
            integral(:, :, z) = integral(:, :, z) + dd(:, :);
        end
        z = z + 1;
    end
    
    integral = integral ./ (iterations + 1);
    
    save(sprintf('c:/work/acquisition/optim/d/%d', i), 'integral');
end

return;

%%% optim for afl. different center for each iterations, min crop width

path = '//192.168.0.105/work/politeh/thrscan/bias200clock16';

energies = [20:27 28:2:50];
%energies = [20 21 22 23 24 25 26 27 28 30 32 34 36 37 38 39 40 42 44 46 48 50];
energies = 41:2:49;
for energy = energies

    filedata = fileread(sprintf('%s/%d/itr.txt', path, energy));
    iterations = sscanf(filedata, '%d');

    minlen = realmax;

    centers = zeros(iterations, 1);

    for itr = 0:iterations
        ds = set(dataset('File', sprintf('%s/%d/%d/%s', path, energy, itr, 'test15.txt')), 'VarNames', {'11'});
        dd = str2num(char(ds.x11));

        [left, right] = reflex_boundaries(dd, 150);
        center = left + round((right - left) / 2);

        centers(itr + 1) = center;
        
        if (center > 128)
            available_len = 1 + (256 - center) * 2;
        else
            available_len = 1 + (center - 1) * 2;
        end

        if (available_len < minlen)
            minlen = available_len;
        end
    end

    files = dir(sprintf('%s/%d/%d/*.txt', path, energy, 0));

    %integral = zeros(200 - 60 + 1, minlen, size(files, 1));
    integral = zeros(240-20+1, minlen, size(files, 1));

    z = 1;

    half = (minlen-1) / 2;

    for file = files'
        if (endsWith(file.name, '.dsc'))
            continue;
        end
        if (file.name == '.')
            continue;
        end

        for itr = 0:iterations
            ds = set(dataset('File', sprintf('%s/%d/%d/%s', path, energy, itr, file.name)), 'VarNames', {'11'});
            dd = str2num(char(ds.x11));

            center = centers(itr + 1);

            %integral(:, :, z) = integral(:, :, z) + dd(60:200, center - half:center + half);
            integral(:, :, z) = integral(:, :, z) + dd(20:240, center - half:center + half);
        end    

        z = z + 1;
    end

    save(sprintf('c:/work/acquisition/optim/%d', energy), 'integral');
    
end
    

