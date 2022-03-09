function [thicks,doses] = doseVersusThick(path, experiment)

%%% !!! Static, experiment depended params are Thickness set, geom, density

thicks = [ 0.1 0.2 0.3 0.5 0.6 0.8 1.3 1.6 2 2.5 3 3.5 4 4.5 5 10 20 30 ];

doses = zeros(numel(thicks), 1);

index = 1;

for t = thicks
    [x, y] = loadXY(sprintf('%s/%d/spectrum_%.1fmm.txt', path, experiment, t));

    detDiam = 5;
    detThick = t / 10;
    V = (pi * detDiam^2 / 4) * detThick;
    p = 7.1;
    m = p * V / 1000; % kg

    q = 1.6021766209 * 10^-19;
    E = (sum(x.*y) * 10^3) * q;

    doses(index) = E / m;
    index = index + 1;
end



