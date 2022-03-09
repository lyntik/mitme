function [x y] = loadXY(s, logarithm)

if nargin < 2
    logarithm = false;
end

ds = dataset('File', s);
dd = double(ds);
x = dd(:, 1);
y = dd(:, 2);
if (logarithm)
    y = log10(y); y(find(y == -Inf)) = 0;
end

