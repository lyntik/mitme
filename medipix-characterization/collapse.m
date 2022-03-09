function [x, y]=collapse(x1, y1)

[x] = unique(x1,'first');
y = zeros(size(x));
for i=1:length(x)
    ind = find(x1 == (x(i)));
%     size(y)
%     size(y1)
%     i
%     ind
    y(i) = sum(y1(ind));
end


