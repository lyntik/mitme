function atts=loadAttenuation(MATERIALS, energyRange)

atts = zeros(size(energyRange, 2), 2);

ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(1))));
dd = double(ds);
index = 1;
for e = energyRange
    %index
    %e
    atts(index, :) = dd(e, :);
    index = index + 1;
end

for i=2:size(MATERIALS, 2)
    ds = dataset('File',sprintf('spectral/linear_attenuations/%s.txt', char(MATERIALS(i))));
    dd = double(ds);
    
    char(MATERIALS(i))
    
    index = 1;
    for e = energyRange
        atts(index, :, i) = dd(e, :);
        index = index + 1;
    end
end

atts = permute(atts(:, 2, :), [3, 1, 2]);