function [offsets] = subPixelOffsets(filePathFormat, shotsNumber, dir, initInd, x1, x2, y1, y2, summDimension)

if (summDimension == 1) 
    initInd = initInd - (x1 - 1);
else
    initInd = initInd - (y1 - 1);
end

offsets = zeros(shotsNumber-1, 1);

initValue = 0;
for i=0:shotsNumber-1
    t = Tiff(sprintf(filePathFormat, i), 'r');
    img = read(t);

    prof = sum(img(y1:y2, x1:x2), summDimension);

    if (i == 0)
        initValue = prof(initInd);
    else
        diff = initValue - prof;
        diff(diff>0) = -realmax;
        ind = find(diff==max(diff));

        offset = abs(ind - initInd);
        l = abs(prof(ind)-prof(ind+dir));
        %sub = (initValue-prof(ind+dir)) / l;
        sub = abs(initValue-prof(ind)) / l;

        if ( (dir == -1  && ((ind - initInd) > 0)) || (dir == 1  && ((ind - initInd) < 0)) )
            offset = offset - sub;
            offset = offset * -1 * dir;
        else
            offset = offset + sub;
            offset = offset * dir;
        end

        offsets(i) = offset;
    end
end    
       
end



