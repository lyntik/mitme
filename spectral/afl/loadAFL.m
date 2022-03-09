function [Rij] = loadAFL()

spectrumRange = 20:30;
depositionRange = 18:2:34; 

n = size(spectrumRange, 2);
dn = size(depositionRange, 2);


Rij = zeros(dn, n);

for e = 20:30
    ds = dataset('File', sprintf('c:/work/acquisition/%d.txt', e));
    dd = double(ds);
    x_ = dd(:,1)';
    y_ = dd(:,2)';

    dn_ = size(x_, 2);
    y = [ y_(2:dn_) zeros(1, dn-(dn_-1)) ];
    
    Rij(:, e - 19) = y;
    
    summ = sum(Rij(:, e - 19), 1);
    Rij(:, e - 19) = Rij(:, e - 19) ./ summ;

end    



