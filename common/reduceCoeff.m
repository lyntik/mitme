function [r] = reduceCoeff(coeff, f)

r = 1 + abs((coeff-1)/f);

% if (coeff > 1)
%     r = 1 + (coeff-1)/f;
% else
%     r = 1 / ((1/coeff) / f);
%end