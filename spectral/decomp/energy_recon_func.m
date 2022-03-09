function [spectrum] = energy_recon_func(Rij, experimentCode, region,  normFactor)

global MEASUREMENT_DATA_PATH;

D = loadDepositedSpectrum(MEASUREMENT_DATA_PATH, experimentCode, 0, region, -1);
D = [D zeros(1, size(Rij, 1) - size(D, 2)) ] ;

optionsSART.nonneg = true;
x0 = zeros(size(Rij, 2), 1);
[spectrum, info] = sart(Rij, double(D'), 100, x0, optionsSART);

if exist('normFactor', 'var')
    spectrum = spectrum * normFactor;
end
    

end
