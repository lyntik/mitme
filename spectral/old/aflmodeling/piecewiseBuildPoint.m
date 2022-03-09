function [y] = piecewiseBuildPoint(energy, x)
global lastEnergy;
global p1;
global p2;
global p3;
global p4;
global a;
global b;
global c;
global dp;

global fitresult;

% afl = zeros(1, 99);
% 
if (energy >= 13 && energy <= 22)
    
    if (lastEnergy ~= energy)
        load(sprintf('thrafl/model/asis/%d.mat', energy), 'fitresult');    
    end
    
%     sum = 0;
%     for i = 1:99
%         afl(i) = feval(fitresult, 15.5 + (i - 1) * 0.5 );
%         sum = sum + afl(i);
%     end
%     
%     for i = 1:99
%         afl(i) = afl(i) / sum;
%     end

    y = feval(fitresult, x);

    lastEnergy = energy;
    return;

end


%bestI = ((dp - 10.5) / 0.5) + 1;
%bestI



if (lastEnergy ~= energy)
    load('thrafl/model3/p1.mat', 'fitresult'); p1 = feval(fitresult, energy);
    load('thrafl/model3/p2.mat', 'fitresult'); p2 = feval(fitresult, energy);
    load('thrafl/model3/p3.mat', 'fitresult'); p3 = feval(fitresult, energy);
    load('thrafl/model3/p4.mat', 'fitresult'); p4 = feval(fitresult, energy);
    load('thrafl/model3/a.mat', 'fitresult'); a = feval(fitresult, energy);
    load('thrafl/model3/b.mat', 'fitresult'); b = feval(fitresult, energy);
    load('thrafl/model3/c.mat', 'fitresult'); c = feval(fitresult, energy);
    load('thrafl/model3/dp.mat', 'fitresult'); dp = feval(fitresult, energy);
    lastEnergy = energy;
end




dpregion = 0.2;

if (x < dp - dpregion)
    y = p1*power(x, 3) + p2*power(x, 2) + p3*power(x, 1) + p4*1;
elseif (x > dp + dpregion)
    y = a*exp(-((x-b)/c)^2);
else
    x1 = dp - dpregion;
    x2 = dp + dpregion;
    y1 = p1*power(x1, 3) + p2*power(x1, 2) + p3*power(x1, 1) + p4;
    y2 = a*exp(-((x2-b)/c)^2);
    
    y = y1 + ((x - x1) / (x2 - x1)) * (y2 - y1);
end





