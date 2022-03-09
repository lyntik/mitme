function [r] = matrixDose(inDir, x1, x2, y1, y2)


r = zeros(y1-y2+1, x2-x1+1);
for x = x1:x2
    for y = y1:y2
        r(y-y1+1, x-x1+1) = dose(inDir, x, y);
    end
end    

