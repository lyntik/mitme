

INC = modelSpectrum(19:40, 200, 30, 20);
Rij = modelResponse(19:40, 19:40, 'Gaussian', 80, 3, 20);

ATT = loadAttenuation({'al', 'cu'}, 19, 40);
D = generateDetectedMeasurement([0.1; 0.02], INC, ATT, Rij, 4);


[f] = decomp(INC, ATT, Rij, D)












