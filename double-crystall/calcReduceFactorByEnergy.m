function[factor, bins] = calcReduceFactorByEnergy(eFrom, eTo, step)


bins = [];
i = 1;

eprev = eFrom;
e = eFrom;
% by energy
while ((e + step) < eTo)
    e = e + step;
    bins(i) = e - eprev;
    eprev = e;
    i = i + 1;
end

summ = sum(bins);

factor = 0;
for i = 1:size(bins, 2)
    factor = factor + (bins(i) / summ) ^ 2;
end