function [meanImg] = meanForPoint2d(img, span)

if (ndims(img) ~= 2)
    errID = 'meanForPoint2d:BadDimsNumber';
    msg = 'Function supports only 2-dimentional images';
    baseException = MException(errID, msg);
    throw(baseException)    
end  

if (span < 0 || x < 1 || y < 1 || x > size(img, 2) || y > size(img, 2))
    errID = 'meanForPoint2d:BadArgument';
    msg = 'BadArgument';
    baseException = MException(errID, msg);
    throw(baseException)    
end  


ind = zeros(size(img, 1), size(img, 2), 'logical');
for x=1:size(img, 2)
    for y=1:size(img, 1)

        ind(:, :) = 0;
        x1 = x - span;
        if (x1 < 1) 
            x1 = 1;
        end
        x2 = x + span;
        if (x2 > size(img, 2)) 
            x2 = size(img, 2);
        end
        y1 = y - span;
        if (y1 < 1) 
            y1 = 1;
        end
        y2 = y + span;
        if (y2 > size(img, 1)) 
            y2 = size(img, 1);
        end
        ind(y1:y2, x1:x2) = 1;

        value = mean(img(ind));
        
    end
end    

