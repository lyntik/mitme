function [snr] = diffraction_snr(dd, slice)

y = dd(slice, :);

noiselvl = sum(y(21:40))/20;
%noiselvl = sum(y(221:240))/20;

[left, right] = reflex_boundaries(y, 1);

snr = noiselvl / ...
    (sum(y(left + 10:right - 10)) / ((right - 10) - (left + 10) + 1));