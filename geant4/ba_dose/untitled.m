
global DATA_PATH;
global XRAY_BASE_PATH;


a = [1; 2];
b = [3; 4];
a+b

return;


thicks = [ 0.1 0.2 0.3 0.5 0.6 0.8 1.3 1.6 2 2.5 3 3.5 4 4.5 5 10 20 30 ];
%thicks = [ 0.1 0.2 0.3 0.4];

colorIndex = 1;

doses = zeros(numel(thicks), 1);
quantum_eff = zeros(numel(thicks), 1);
interactions = zeros(numel(thicks), 1);
peaktototal = zeros(numel(thicks), 1);

index = 1;

keV = 1004;

for t = thicks

    s = sprintf('/home/fna/dev/lab3a/build/%d/spectrum_%.1fmm.txt', keV, t);
    ds = dataset('File', s);
    dd = double(ds);
    x = dd(:, 1);
    y = dd(:, 2); %y = log10(y);
    %plot(x(5:end), y(5:end), '.-b'); hold on;

    detDiam = 5;
    detThick = t / 10;
    V = (pi * detDiam^2 / 4) * detThick;
    p = 2.33;
    m = p * V / 1000; % kg

    q = 1.6021766209 * 10^-19;
    E = (sum(x.*y) * 10^3) * q;
    
    doses(index) = E / m;
    %quantum_eff(index) = (1-exp(-1.02169*t));
    %quantum_eff(index) = (1-exp(-0.233*t));
    interactions(index) = sum(y(2:end)) / sum(y);
    %peaktototal(index) = y(keV+1) / sum(y(2:end));
    index = index + 1;
    %E / m

    %y(1)
    %sum(y)
end


figure('rend', 'painters', 'pos', [500 500 1100 800]);
suptitle({sprintf('Si 10 cm, %d keV', keV),''})
subplot(4,1,1);
plot(thicks, doses, '.-b'); hold on;
title('Calculated dose');
xlabel('Thickness, mm');
ylabel('Dose, grey');

subplot(4,1,2);
plot(thicks, quantum_eff, '.-b'); hold on;
title('Quantum efficiency');
xlabel('Thickness, mm');
ylabel('QE %');

subplot(4,1,3);
plot(thicks, interactions, '.-r'); hold on;
title('Geant interactions %');
xlabel('Thickness, mm');
ylabel('%');

subplot(4,1,4);
plot(thicks, peaktototal, '.-k'); hold on;
title('Peak to total');
xlabel('Thickness, mm');
ylabel('%');





legend('show');






