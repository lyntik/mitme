function [left, right] = reflex_boundaries(dd, slice)

y = dd(slice, :);

noiselvl = sum(y(1:20))/20;

left = -1;
for x = 20:255
    if (y(x) > noiselvl * 10)
        left = x;
        break;
    end
end

right = -1;
for x = 255:-1:1
    if (y(x) > noiselvl * 10)
        right = x;
        break;
    end
end

%snr = noiselvl / (sum(y(left + 10:right - 10)) / ((right - 10) - (left + 10) + 1))