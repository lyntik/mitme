function D=generateDetectedMeasurement(X, INC, ATT, Rij, numberOfBins)

n = size(INC, 1);
ATTEDINC = INC .* prod(exp(-(ATT .* repmat(X, 1, n))), 1)';
D = ATTEDINC' * Rij';
b = size(D', 1) - mod(size(D', 1), numberOfBins);
D = D(1:b);
D = sum(reshape(D, b / numberOfBins, numberOfBins, 1))';

