function [y x] = histo(data, bins, binWidth)

mean_ = mean(mean(data), 2);
left = mean_ - (bins/2)*binWidth;
right = mean_ + (bins/2)*binWidth;

y=zeros(bins, 1); 
for i=1:length(data)

    if (data(i) < left) 
        continue;
    end
    if (data(i) > (right-0.01)) 
        continue;
    end
    ind = floor((data(i)-left)/binWidth)+1;
    y(ind) = y(ind) + 1;
end

x = (left+binWidth/2:binWidth:right-binWidth/2)';
