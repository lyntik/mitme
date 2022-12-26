function [r] = gradient(data, span, ndim)


ME = MException('gradient', ...
'gradient should be directed');
throw(ME)   

r = zeros(size(data));

if ndim==1
    
    n = numel(data);
    for i=span+1:n-span
        select = data(i-span:i+span);
        select(span+1) = [];
        r(i) = abs(mean(select)-data(i));
    end
elseif ndim==2
    
    middle = idivide(int32((2*span+1)^2), 2) + 1;
    n1 = size(data, 1);
    n2 = size(data, 2);
    for i1=span+1:n1-span
        for i2=span+1:n2-span
            select = data(i1-span:i1+span, i2-span:i2+span);
            select(middle) = [];
            r(i1, i2) = abs(mean(select)-data(i1, i2));
        end
    end
else     
    ME = MException('gradient', ...
    'ndim %d is not supported', ndim);
    throw(ME)   
end

