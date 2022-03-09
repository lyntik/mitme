function [x, d] = distributeBin(p) 


n = idivide(int32(p(2) - p(1)), 2);
if (even) 
    n = n - 0.5;
end

n = n + p(2) + idivide(int32(p(3) - p(2)), 2);
if (even) 
    n = n - 0.5; 
end



