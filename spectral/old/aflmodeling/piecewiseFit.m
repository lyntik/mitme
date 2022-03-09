function [coeffs1, coeffs2, dp, fittedAfl] = piecewiseFit(e, x, y)

bestRSquare = 0;
bestI = 0;

if (e == 20) 
    bestI = 5;
end

if (bestI == 0)
    
%start = round((e - 15.25) * 2);
start = round((e - 10.25) * 2);

for i = start-10:start+5
    xx = x(1:i);
    yy = y(1:i);
    
    [xData, yData] = prepareCurveData( xx, yy );
    % Set up fittype and options.
    ft = fittype( 'poly3' );
    opts = fitoptions( ft );
    opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf];
    opts.Upper = [Inf Inf Inf Inf Inf Inf];
    % Fit model to data.
    [fitresult1, gof1] = fit( xData, yData, ft, opts );
    
    
    
    
    xx = x(i+1:size(x,2));
    yy = y(i+1:size(y,2));    
    
    [xData, yData] = prepareCurveData( xx, yy );
    % Set up fittype and options.
    ft = fittype( 'gauss1' );
    opts = fitoptions( ft );
    opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf];
    opts.Upper = [Inf Inf Inf Inf Inf Inf];
    % Fit model to data.
    [fitresult2, gof2] = fit( xData, yData, ft, opts );
    
    rsquare = gof1.rsquare + gof2.rsquare;
    disp(sprintf('%d: %.4f %.4f %.4f', i, gof1.rsquare, gof2.rsquare, rsquare));
    
    if (rsquare > bestRSquare)
        bestRSquare = rsquare;
        bestI = i;
    end
end

end
 




disp(sprintf('bestI - %d', bestI));

xx = x(1:bestI);
yy = y(1:bestI);

[xData, yData] = prepareCurveData( xx, yy );
% Set up fittype and options.
ft = fittype( 'poly3' );
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf];
opts.Upper = [Inf Inf Inf Inf Inf Inf];
% Fit model to data.
[fitresult1, gof1] = fit( xData, yData, ft, opts );
coeffs1 = coeffvalues(fitresult1);
%plot(fitresult1, '.-r');

%return;


xx = x(bestI+1:size(x,2));
yy = y(bestI+1:size(y,2));    

[xData, yData] = prepareCurveData( xx, yy );
% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf];
opts.Upper = [Inf Inf Inf Inf Inf Inf];
% Fit model to data.
[fitresult2, gof2] = fit( xData, yData, ft, opts );
coeffs2 = coeffvalues(fitresult2);


% format long;
% disp('25 kEv');
% 10.5 + (bestI-1)*0.5
% coeffs1
% coeffs2


dp = x(1) + (bestI-1)*0.5;

fittedAfl = zeros(1, size(x, 2));
for i = 1:size(x, 2)
    if (i < bestI)
        fittedAfl(i) = feval(fitresult1, x(1) + 0.5 * (i-1));
    elseif (i == bestI)
        fittedAfl(i) = (feval(fitresult1, x(1) + 0.5 * (i-2)) + feval(fitresult2, x(1) + 0.5 * (i))) / 2;
    else
        fittedAfl(i) = feval(fitresult2, x(1) + 0.5 * (i-1));
    end
end



