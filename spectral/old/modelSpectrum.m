function f=modelSpectrum(spectrumRange, a1, b1, c1)

n = size(spectrumRange, 2);

spectrum = zeros(size(spectrumRange, 2), 1);

% 100, 30, 5)

index = 1;
for i = spectrumRange
    spectrum(index) = gauss0(a1, b1, c1, i, 0) + gauss0(100, 28, 1, i, 0);
    index = index + 1;
end

f = spectrum;
