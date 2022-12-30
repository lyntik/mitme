function [r] = appendMiddle(ind, append, ndim)

r = ind;

if ndim==1
    
%     n = numel(data);
%     for i=span+1:n-span
%         v1 = mean(data(i-span:i-1));
%         v2 = mean(data(i:i+span-1));
%         r(i) = abs(v1-v2);
%     end
elseif ndim==2
    
    n1 = size(ind, 1);
    n2 = size(ind, 2);
    
    for i1=append+1:n1-append
        for i2=append+1:n2-append
            if (ind(i1, i2) == 1)
                for ii1=i1-append:i1+append
                    for ii2=i2-append:i2+append
                        if (ind(ii1, ii2) == 3)
                            r(ii1, ii2) = 2;
                        end
                    end
                end
            end
        end
    end    
    
else     
    ME = MException('gradient', ...
    'ndim %d is not supported', ndim);
    throw(ME)   
end

