function [r] = borderSum(a, border)
r = zeros(size(a));
r = r(1:size(border, 2)+1);
offset = 1;
for i = 1:size(border, 2)
    r(i) = sum(a(offset:border(i)));
    offset = offset + (border(i) - offset) + 1;
end
r(i+1) = sum(a(offset:end));
end

