function [coeffs, yout] = fito(x, y, model)

[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( model );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
% opts.Lower = [-Inf -Inf 0];
% opts.StartPoint = [69 2721 904.021959439225];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );


coeffs = coeffvalues(fitresult);
if (nargout > 1) yout = feval(fitresult, x); end

