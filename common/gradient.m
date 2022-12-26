function [r] = gradient(data, span, ndim)

r = zeros(size(data));

if ndim==1
    
    n = numel(data);
    for i=span+1:n-span
        v1 = mean(data(i-span:i-1));
        v2 = mean(data(i:i+span-1));
        r(i) = abs(v1-v2);
    end
elseif ndim==2
    
    n1 = size(data, 1);
    n2 = size(data, 2);
    for i1=span+1:n1-(span-1)
        for i2=span+1:n2-(span-1)
            v1 = mean(data(i1-span:i1+span-1, i2-span:i2-1));
            v2 = mean(data(i1-span:i1+span-1, i2:i2+span-1));
            
            r(i1, i2) = abs(v1-v2);
        end
    end
else     
    ME = MException('gradient', ...
    'ndim %d is not supported', ndim);
    throw(ME)   
end

