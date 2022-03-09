function [y_R] = stack(en, g1, g2)


%%% 1 cluster
ds = dataset('File', sprintf('/home/fna/data/medipix/test%04d_1.txt', en));
dd = double(ds);
x = dd(:,1);
y = dd(:,2); 

mult = 30;
x = round(double(g1(x)) * mult);
y_reduced = y; 
for i = 2:numel(x)-1
    y_reduced(i) = y(i) / reduceBinValueForDistrub(x(i-1:i+1));
end
y_reduced(1) = floor(y_reduced(2));
y_reduced(end) = floor(y_reduced(end-1));

x_reduced = [1; x(1)-1; x; x(end)+1; 3000];
y_reduced = [ 0; 0; y_reduced; 0; 0 ];

    
[xData, yData] = prepareCurveData( x_reduced, y_reduced );
[fitresult, gof] = fit( xData, yData, 'pchipinterp', 'Normalize', 'on' );

%x_interp = 1:3000;
y_interp = zeros(3000, 1);
for i = x(1):3000
    y_interp(i) = feval(fitresult, i);
end

y_R = sum(reshape(y_interp, 15, 200), 1);


%%% 2 cluster

ds = dataset('File', sprintf('/home/fna/data/medipix/test%04d_2.txt', en));
dd = double(ds);
x = dd(:,1);
y = dd(:,2); 

mult = 30;
x = round(double(g2(x)) * mult);
y_reduced = y; 
for i = 2:numel(x)-1
    y_reduced(i) = y(i) / reduceBinValueForDistrub(x(i-1:i+1));
end
y_reduced(1) = floor(y_reduced(2));
y_reduced(end) = floor(y_reduced(end-1));

x_reduced = [1; x(1)-1; x; x(end)+1; 3000];
y_reduced = [ 0; 0; y_reduced; 0; 0 ];

    
[xData, yData] = prepareCurveData( x_reduced, y_reduced );
[fitresult, gof] = fit( xData, yData, 'pchipinterp', 'Normalize', 'on' );

%x_interp = 1:3000;
y_interp = zeros(3000, 1);
for i = x(1):3000
    y_interp(i) = feval(fitresult, i);
end

y_R = y_R + sum(reshape(y_interp, 15, 200), 1);








