
function f=cost(X, INC, D, Rij, ATT)

LAMBDA = generateDetectedMeasurement(X, INC, ATT, Rij, 4);

measurements = size(D, 2);
f = 0.0;
for measure = 1:measurements
    for bin = 1:size(D, 1)
        %f = f + (LAMBDA(bin) - DETBINS(bin, measure)) ^ 2; % lsquares
        %f = f + abs(LAMBDA(bin) - DETBINS(bin, measure)); % straight
        f = f + (LAMBDA(bin) - log(LAMBDA(bin)) * D(bin, measure)); % MLEM
    end
end


 %X
 %f


