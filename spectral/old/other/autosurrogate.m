
fromE = 19;
toE = 53;

means = zeros(fromE:5:toE);

i = 1;

for tot = fromE:5:toE
    
    ds = dataset('File',sprintf('txt/e_%d.txt', tot));
    dd = double(ds);
    x = dd(:,1);
    y = dd(:,2);
    
    % Set up fittype and options.
    [xData, yData] = prepareCurveData( x, y );

    ft = fittype( 'gauss1' );
    opts = fitoptions( ft );
    opts.Display = 'Off';
    opts.Lower = [-Inf -Inf 0];
    opts.Upper = [Inf Inf Inf];

    % Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );
   
    coeffs = coeffvalues(fitresult);
    
    means(i) = coeffs(2);
    i = i + 1;
    
end


[xData, yData] = prepareCurveData( fromE:5:toE, means );

% Set up fittype and options.
ft = fittype( 'a*x+b-c/(x-t)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

coeffs = coeffvalues(fitresult);
a = coeffs(1);
b = coeffs(2);
c = coeffs(3);
t = coeffs(4);

% Output 
fprintf('surrogate coeffs: a - %.4f b - %.4f c - %.4f t - %.4f\n', a, b, c, t);

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'y vs. x', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel y
grid on

% save to disk for future use by spectral processing
toenergyfit = fitresult;
save('surrogatefit', 'toenergyfit');



