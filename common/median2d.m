function [r] = median2d(profile, span)
n = numel(profile);
r = profile;
for x=span+1:n-span-1
    r(x) = median(profile(x-span:x+span));
end