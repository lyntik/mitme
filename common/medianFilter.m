function [r] = medianFilter(data, span, ndim)

r = data;

if ndim==1
    n = numel(data);
    for i=span+1:n-span
        r(i) = median(data(i-span:i+span));
    end
elseif ndim==2
    
    n = (2*span+1)^2;
    n1 = size(data, 1);
    n2 = size(data, 2);

    for i1=1:n1
        for i2=1:n2
            select = data(max(i1-span, 1):min(i1+span, n1), max(i2-span, 1):min(i2+span, n2));
            r(i1, i2) = median(select(:));
        end
    end
    
    
%     for i1=span+1:n1-span
%         for i2=span+1:n2-span
%             select = reshape(data(i1-span:i1+span, i2-span:i2+span), [n 1]);
%             r(i1, i2) = median(select);
%         end
%     end
            
else     
    ME = MException('medianFilter', ...
    'ndim %d is not supported', ndim);
    throw(ME)   
end

