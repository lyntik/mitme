function y=sumByX(x1, x2, y1, y2)

y=y1;

for i=1:size(x1, 1)
    ind = find(x2==x1(i));
    if (~isempty(ind))
        y1(i) = y1(i) + y2(ind);
    end
end