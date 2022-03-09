function [afl] = piecewiseBuild(e, noise)

if (nargin == 1)
    noise = 0;
end

ds = dataset('File',sprintf('thrafl/%d.txt', e * 1000));
dd = double(ds);
x = dd(:,1)';
y = dd(:,2)';

afl = y(1:22);

if (noise ~= 0)
    
    perc = noise * 0.01;

    summ = 0;
    for i = 1:size(afl, 2)
        afl(i) = afl(i) + ((afl(i) * perc * 2) * rand(1, 1) - afl(i) * perc);
        summ = afl(i) + summ;
    end
    for i = 1:size(afl, 2)
        afl(i) = afl(i) / summ;
    end
    
    
end



return;

x = 14.5:0.1:55.4;
y = zeros(1, size(x, 2));
i = 1;
for point = x
    y(i) = piecewiseBuildPoint(e, point);
    i = i + 1;
end

sum2 = 0;
bins = 15:55;
afl = zeros(1, size(bins, 2));
for bin = bins
    sum = 0;
    %xx
    for x = bin-0.5:0.1:bin+0.4
        sum = sum + y(round((x - 14.5) / 0.1 + 1));
    end
    
    afl(bin - 14) = sum;
    sum2 = sum2 + sum;
end

for bin = bins
    afl(bin - 14) = afl(bin - 14) / sum2;
end

%plot(x, y, '.-b'); hold on;
%axis([15, 60, 0 0.1]);


return;




afl = zeros(1, 99);

if (energy >= 13 && energy <= 22)
    load(sprintf('thrafl/model/asis/%d.mat', energy), 'fitresult');
    
    sum = 0;
    for i = 1:99
        afl(i) = feval(fitresult, 15.5 + (i - 1) * 0.5 );
        sum = sum + afl(i);
    end
    
    for i = 1:99
        afl(i) = afl(i) / sum;
    end

    return;

end


%bestI = ((dp - 10.5) / 0.5) + 1;
%bestI


load('thrafl/model3/p1.mat', 'fitresult'); p1 = feval(fitresult, energy);
load('thrafl/model3/p2.mat', 'fitresult'); p2 = feval(fitresult, energy);
load('thrafl/model3/p3.mat', 'fitresult'); p3 = feval(fitresult, energy);
load('thrafl/model3/p4.mat', 'fitresult'); p4 = feval(fitresult, energy);

load('thrafl/model3/a.mat', 'fitresult'); a = feval(fitresult, energy);
load('thrafl/model3/b.mat', 'fitresult'); b = feval(fitresult, energy);
load('thrafl/model3/c.mat', 'fitresult'); c = feval(fitresult, energy);

load('thrafl/model3/dp.mat', 'fitresult'); dp = feval(fitresult, energy);

bestI = round((dp - 14.75) / 0.5 + 1);

afl = zeros(1, 99);
for i = 1:99
    
    x = 14.75 + (i - 1) * 0.5;
    
    if (i < bestI)
        afl(i) = p1*power(x, 3) + p2*power(x, 2) + p3*power(x, 1) + p4;
    elseif (i == bestI)
        x = x - 0.5;
        y1 = p1*power(x, 3) + p2*power(x, 2) + p3*power(x, 1) + p4;
        x = x + 1;
        y2 = a*exp(-((x-b)/c)^2);
        afl(i) = (y2 + y1) / 2;
    else
        afl(i) = a*exp(-((x-b)/c)^2);
    end
end



