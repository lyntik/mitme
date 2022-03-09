function[factor] = calcReduceFactorByAngle(braggFrom, braggTo, step)

angle = braggFrom;

eprev = 12.4 / (sin(rad(angle)) * 2.72);

bins = [];
i = 1;
%%% by angle
while ((angle - step) > braggTo)
    angle = angle - step;
    e = 12.4 / (sin(rad(angle)) * 2.72);
    bins(i) = e - eprev;
    eprev = e;
    i = i + 1;
end

summ = sum(bins);

factor = 0;
for i = 1:size(bins, 2)
    factor = factor + (bins(i) / summ) ^ 2;
end

