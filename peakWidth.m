function w=peakWidth(x, yData, pixelsDown)

for x1=x:-1:1
    if (yData(x1) < (yData(x) - pixelsDown))
        break;
    end
end    

for x2=x:1:numel(yData)
    if (yData(x2) < (yData(x) - pixelsDown))
        break;
    end
end    

wDown = x2 - x1;

for x1=x:-1:1
    if (yData(x1) > (yData(x) + pixelsDown))
        break;
    end
end    

for x2=x:1:numel(yData)
    if (yData(x2) > (yData(x) + pixelsDown))
        break;
    end
end    

wUp = x2 - x1;

w = min(wDown, wUp);