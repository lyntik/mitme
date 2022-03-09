function [y] = plotAxePlay(path, shots, expNumber, x, y, axe, typeStr, displayName, charRange)

if nargin < 9 || isempty(charRange)
    charRange = 1:expNumber;
end

t = Tiff(sprintf('%s/000_0000.tif', path) ,'r');
img = read(t);

if (axe == 'x')
    p1 = mean(img(y, x));
    p2 = mean(img(y, x+1));
    p3 = mean(img(y, x+2));
else
    p1 = mean(img(y, x));
    p2 = mean(img(y+1, x));
    p3 = mean(img(y+2, x));
end    
   
p2_ = zeros(expNumber, 1);
p2per_ = zeros(expNumber, 1);


for exp=0:expNumber-1
    t = Tiff(sprintf('%s/%03d_%04d.tif', path, exp, shots) ,'r');
    img = read(t);

    if (axe == 'x')
        v = mean(img(y, x+1));
    else
        v = mean(img(y+1, x));
    end
    
    p2_(exp+1) = v;
    
    if ((v - p2) * (p1 - p2)) > 0
        p2per_(exp+1) = (v - p2) / (p1 - p2) * 100;
    else
        p2per_(exp+1) = (v - p2) / (p3 - p2) * 100;
    end
end    

neighPerDiff = zeros(expNumber, 1);
neighPerDiff(1) = p2per_(1);
for exp=2:expNumber
    neighPerDiff(exp) = abs(p2per_(exp-1) - p2per_(exp));
end


global colors;
global colorIndex;
colorIndex = colorIndex + 1;
if (colorIndex == 8)
    colorIndex = 1;
end

if (typeStr == "per")
    
    neigh = neighPerDiff(charRange);
    neightDisp = 0;
    for i=1:numel(neigh)
        neightDisp = neightDisp + neigh(i)^2;
    end
    neightDisp = neightDisp / (2*(numel(neigh)-1));
    
    %plot(1:expNumber, p2per_, char(colors(colorIndex)), 'DisplayName', sprintf('%s NEIGH DIFF for range %d:%d (avg %.2f, max %.2f, dispertion %.2f)', displayName, charRange(1), charRange(end), mean(neigh), max(neigh), neightDisp)); hold on;
    plot(1:expNumber, p2per_, char(colors(colorIndex)), 'DisplayName', sprintf('%s', displayName)); hold on;
    
    if nargin >= 9 
        colorIndex = colorIndex + 1;
        if (colorIndex == 8)
            colorIndex = 1;
        end    
        y = p2per_(charRange);
        [xData, yData] = prepareCurveData( charRange', y );
        ft = fittype( 'poly1' );
        [fitresult, gof] = fit( xData, yData, ft );
        c = coeffvalues(fitresult);
        syms x;
        f(x) = c(1)*x + c(2);
        plot(charRange, f(charRange), char(colors(colorIndex)), 'DisplayName', sprintf('linear part %.4f*x', c(1))); hold on;
    end
    
    ylim([0 140])
elseif (typeStr == "per1")
    
    neigh = neighPerDiff(charRange);
    neightDisp = 0;
    for i=1:numel(neigh)
        neightDisp = neightDisp + neigh(i)^2;
    end
    neightDisp = neightDisp / (2*(numel(neigh)-1));
    
    plot(1:expNumber, p2per_, char(colors(colorIndex)), 'DisplayName', sprintf('%s neighbor diff for range %d:%d (avg %.2f, max %.2f, dispertion %.2f)', displayName, charRange(1), charRange(end), mean(neigh), max(neigh), neightDisp)); hold on;
    
    if nargin >= 9 
        colorIndex = colorIndex + 1;
        if (colorIndex == 8)
            colorIndex = 1;
        end    
        y = p2per_(charRange);
        [xData, yData] = prepareCurveData( charRange', y );
        ft = fittype( 'poly1' );
        [fitresult, gof] = fit( xData, yData, ft );
        c = coeffvalues(fitresult);
        syms x;
        f(x) = c(1)*x + c(2);
        plot(charRange, f(charRange), char(colors(colorIndex)), 'DisplayName', sprintf('linear part %.4f*x', c(1))); hold on;
    end
    
    ylim([0 140])    
    
elseif (typeStr == "perdiff")
    plot(1:expNumber, neighPerDiff, char(colors(colorIndex)), 'DisplayName', sprintf('%s (avg %.2f%%, min %.2f%%, max %.2f%%)', displayName, mean(neighPerDiff), min(neighPerDiff), max(neighPerDiff)) ); hold on;
elseif (typeStr == "value")
    plot(1, p1, 'k*'); hold on;
    plot(1, p2, 'b*'); hold on;
    plot(1, p3, 'g*'); hold on;
    plot(1:expNumber, p2_, char(colors(colorIndex)), 'DisplayName', displayName); hold on;
else
    ME = MException('plotAxePlay', ...
        'Plot type %s is unknown', type);
    throw(ME)    
end

