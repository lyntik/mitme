

figure('Renderer', 'painters', 'Position', [10 10 400 300]);
set(0,'defaultAxesFontSize',12)

means = zeros(256, 1);
i = 1;

c = 1;


for coor = 0:255

    [x y] = loadXY(sprintf('/home/fna/share/eachpix/%d_120_%02d.txt', c, coor)); 
    x = x(1:100);
    y = y(1:100)./1;
    

    if (c == 1)
        x=x(15:end);
        y=y(15:end);
    end
    
    if (c == 3)
        x=x(1:30);
        y=y(1:30);
    end
    
%     plot(x, y, '.-b'); hold on;
%     
%     return;
   
    [xData, yData] = prepareCurveData( x, y );

    % Set up fittype and options.
    ft = fittype( 'gauss1' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.Lower = [-Inf -Inf 0];
    opts.StartPoint = [1370 20 3.51834348231576];

    % Fit model to data.
    [fitresult, gof] = fit( xData, yData, ft, opts );    
    coeffs = coeffvalues(fitresult);
    
    means(i) = coeffs(2);
    i = i + 1;
end    



plot(1:256, means, '.-b');
xlim([ 1 256]);
min(means)
max(means)
max(means)-min(means)
std(means)

xlabel('Column');
ylabel('Photopeak mean, TOT');
print('-clipboard','-dbitmap');

%legend('show');

return;


