function [r] = matrixDose(inDir, conf, matrixNumber, x1, x2, y1, y2)

if nargin <= 3 
  x1 = 1;
  x2 = 30;
  y1 = 1;
  y2 = 30;
end

r = zeros(30, 30);
for x = x1:x2
    for y = y1:y2
        r(y, x) = dose(inDir, conf, matrixNumber, x - 1, y - 1);
    end
end    

