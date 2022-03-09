
energies = [15 17 20 25 30 35];

colorIndex = 1;

for e=energies
    [x, y] = loadXY(sprintf('/media/fna/storage 2T/bring/data/medipix/8/test%04d_2.txt', e));
    
    plot(x, y, char(colors(colorIndex)), 'DisplayName', sprintf('%d keV', e)); hold on;
    colorIndex = colorIndex + 1;
    if (colorIndex == 8)
        colorIndex = 1;
    end
    
end

legend('show');
xlabel('Time over threshold (TOT)');
ylabel('Counts, N');

return;

x = [13 15 17 20 25 30 35];
y = [36 47 62 86 115 138 161];

scatter(x, y, 'k', 'DisplayName',  'Calibration points'); hold on;
legend('show');
xlabel('Energy, keV');
ylabel('Time over threshold (TOT)');

syms x;
f(x) = 4.863*x-1.916-140.6/(x-8);

fplot(@(x) f(x), [13 35], 'b', 'DisplayName', 'Calibration curve'); hold on;

return;
