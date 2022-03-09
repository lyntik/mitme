function [n] = reduceBinValueForDistrub(p) 


n = double(idivide(int32(p(2) - p(1)), 2));
even = mod(p(2) - p(1), 2) == 0;
if (even) 
    n = n - 0.5;
end

n = n + 1;

n = n + double(idivide(int32(p(3) - p(2)), 2));
even = mod(p(3) - p(2), 2) == 0;
if (even) 
    n = n - 0.5; 
end



