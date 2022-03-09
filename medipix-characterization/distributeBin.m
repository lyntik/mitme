function [x, d] = distributeBin(p, v) 


pstart = p(2) - idivide(int32(p(2) - p(1)), 2);
even = mod(p(2) - p(1), 2) == 0;
ystep = (v(2) - v(1)) / (p(2) - p(1));

index = 1;
d = [];
d(index) = v(1) + (v(2) - v(1)) / 2;
if (~even) 
    d(index) = d(index) + ystep / 2;
end
index = index + 1;
for point = pstart+1:p(2)
    d(index) = d(index - 1) + ystep;
    index = index + 1;
end
if (even) 
    d(1) = d(1) / 2; 
end


pend = p(2) + idivide(int32(p(3) - p(2)), 2);
even = mod(p(3) - p(2), 2) == 0;
ystep = (v(3) - v(2)) / (p(3) - p(2))

for point = p(2)+1:pend
    d(index) = d(index - 1) + ystep;
    index = index + 1;
end
if (even) 
    d(end) = d(end) / 2; 
end

d = d ./ sum(d) .* v(2);

x = pstart:pend;



